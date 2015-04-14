﻿using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Web;

namespace MagicCMS.Core
{
    public class Miniatura : IDisposable
    {
        /// <summary>
        /// Crea un oggetto Miniatura vuoto
        /// </summary>
        public Miniatura()
        {
            Pk = 0;
            Opath = "";
            Width = 0;
            Height = 0;
            BmpData = null;
            OdateTicks = 0;
        }

        /// <summary>
        /// Recupera un'ogetto miniatura dal database.
        /// </summary>
        /// <param name="pk">Id dell'oggetto memorizzato</param>
        public Miniatura(int pk)
        {
            Init(pk);
        }

        /// <summary>
        /// Cerca un'oggetto Miniatura nel database. Se non esiste lo crea.
        /// </summary>
        /// <param name="url">Url dell'immagine</param>
        /// <param name="width">Larghezza della miniatura.</param>
        /// <param name="height">Altezza della miniatura.</param>
        public Miniatura(string url, int width, int height)
        {
            Init(url, width, height);
        }

        /// <summary>
        /// Cerca un'oggetto Miniatura nel database. Se non esiste lo crea.
        /// </summary>
        /// <param name="fisicalpath">Path fisico del file.</param>
        /// <param name="width">Larghezza della miniatura.</param>
        /// <param name="height">Altezza della miniatura.</param>
        /// <param name="fileDate">Data ultima modifica del file.</param>
        public Miniatura(string fisicalpath, int width, int height, DateTime fileDate)
        {
            Init(fisicalpath, width, height, fileDate);
        }

        ~Miniatura()
        {
            Dispose(false);
        }

        public void Dispose()
        {
            Dispose(true);
        }

        public int Insert()
        {

            if (Pk == 0 && File.Exists(Opath) && Width != 0 && Height != 0 && BmpData != null && OdateTicks != 0)
            {

                SqlConnection conn = new SqlConnection(MagicUtils.MagicConnectionString);
                string cmdstr = "	INSERT IMG_MINIATURE  " +
                                "		( " +
                                "			IMG_MIN_OPATH,  " +
                                "			IMG_MIN_BIN,  " +
                                "			IMG_MIN_HEIGHT,  " +
                                "			IMG_MIN_WIDTH,  " +
                                "			IMG_MIN_ODATE_TICKS " +
                                "		)  " +
                                "		VALUES  " +
                                "		( " +
                                "			@OPATH, " +
                                "			@BIN, " +
                                "			@HEIGHT, " +
                                "			@WIDTH, " +
                                "			@ODATE_TICKS " +
                                "		) " +
                                "	SELECT @@identity  ";

                SqlCommand cmd = new SqlCommand(cmdstr, conn);
                try
                {
                    MemoryStream ms = new MemoryStream();
                    BmpData.Save(ms, ImageFormat.Jpeg);
                    ms.Position = 0;
                    Byte[] imgBuffer = new Byte[ms.Length];
                    ms.Read(imgBuffer, 0, (int)ms.Length);
                    conn.Open();
                    cmd.Parameters.AddWithValue("@OPATH", Opath);
                    cmd.Parameters.AddWithValue("@BIN", imgBuffer);
                    cmd.Parameters.AddWithValue("@HEIGHT", Height);
                    cmd.Parameters.AddWithValue("@WIDTH", Width);
                    cmd.Parameters.AddWithValue("@ODATE_TICKS", OdateTicks);
                    Pk = Convert.ToInt32(cmd.ExecuteScalar());
                }
                finally
                {
                    //if (conn.State == ConnectionState.Open)
                    //    conn.Close();
                    conn.Dispose();
                    cmd.Dispose();
                }
            }
            return Pk;
        }

        private void Dispose(Boolean disposing)
        {
            if (!disposed)
            {

                if (disposing)
                {
                    if (this.BmpData != null)
                        this.BmpData.Dispose();
                }
            }
            disposed = true;

        }

        private void Init(int pk)
        {
            SqlConnection conn = new SqlConnection(MagicUtils.MagicConnectionString);
            string cmdstr =  "	SELECT " +
                             "			IM.IMG_MIN_PK, " +
                             "			IM.IMG_MIN_OPATH, " +
                             "			IM.IMG_MIN_BIN, " +
                             "			IM.IMG_MIN_HEIGHT, " +
                             "			IM.IMG_MIN_WIDTH, " +
                             "			IM.IMG_MIN_ODATE_TICKS " +
                             "	FROM IMG_MINIATURE IM  " +
                             "	WHERE IM.IMG_MIN_PK = @PK  ";

            SqlCommand cmd = new SqlCommand(cmdstr, conn);
            try
            {
                conn.Open();
                cmd.Parameters.AddWithValue("@PK", pk);
                SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.SingleRow);
                if (reader.HasRows)
                {
                    Populate(reader);
                }
                else
                {
                    Pk = 0;
                }
            }
            finally
            {
                //if (conn.State == ConnectionState.Open)
                //    conn.Close();
                conn.Dispose();
                cmd.Dispose();
            }
        }

        private void Init(string url, int width, int height)
        {
            string path = HttpContext.Current.Server.MapPath(url);
            FileInfo fi = new FileInfo(path);
            DateTime fileDate;
            if (fi.Exists)
                fileDate = fi.LastWriteTime;
            else
                fileDate = DateTime.Now;
            Init(path, width, height, fileDate);
                
        }

        private void Init(string path, int width, int height, DateTime fileDate)
        {
            SqlConnection conn = new SqlConnection(MagicUtils.MagicConnectionString);
            string cmdstr = "	SELECT " +
                            "			IM.IMG_MIN_PK, " +
                            "			IM.IMG_MIN_OPATH, " +
                            "			IM.IMG_MIN_BIN, " +
                            "			IM.IMG_MIN_HEIGHT, " +
                            "			IM.IMG_MIN_WIDTH, " +
                            "			IM.IMG_MIN_ODATE_TICKS " +
                            "	FROM IMG_MINIATURE IM " +
                            "	WHERE IM.IMG_MIN_OPATH = @OPATH  " +
                            "			AND IM.IMG_MIN_HEIGHT = @HEIGHT  " +
                            "			AND IM.IMG_MIN_WIDTH = @WIDTH  " +
                            "			AND IM.IMG_MIN_ODATE_TICKS = @ODATE_TICKS ";

            SqlCommand cmd = new SqlCommand(cmdstr, conn);
            try
            {
                conn.Open();
                cmd.Parameters.AddWithValue("@OPATH", path);
                cmd.Parameters.AddWithValue("@HEIGHT", height);
                cmd.Parameters.AddWithValue("@WIDTH", width);
                cmd.Parameters.AddWithValue("@ODATE_TICKS", fileDate.Ticks);
                SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.SingleRow);
                if (reader.HasRows)
                {
                    Populate(reader);
                }
                else if (!File.Exists(path))
                {
                    return;
                }
                else
                {
                    Pk = 0;
                    Width = width;
                    Height = height;
                    Opath = path;
                    OdateTicks = fileDate.Ticks;
                    BmpData = CreateThumbnail(path, width, height);
                    Insert();
                }
            }
            finally
            {
                //if (conn.State == ConnectionState.Open)
                //    conn.Close();
                conn.Dispose();
                cmd.Dispose();
            }
        }

        private void Populate(SqlDataReader reader)
        {
            if (reader.Read())
            {
                Pk = Convert.ToInt16(reader.GetValue(0));
                Opath = Convert.ToString(reader.GetValue(1));
                object img = reader.GetValue(2);
                if (img != null)
                {
                    MemoryStream ms = new MemoryStream((byte[])img);
                    Bitmap b = new Bitmap(ms);
                    BmpData = b;
                }
                Height = Convert.ToInt32(reader.GetValue(3));
                Width = Convert.ToInt32(reader.GetValue(4));
                OdateTicks = Convert.ToInt64(reader.GetValue(5));
            }
        }

        private static Bitmap CreateThumbnail(string path, int lnWidth, int lnHeight)
        {
            Bitmap loBMP = new Bitmap(path);
            System.Drawing.Bitmap bmpOut = null;
            //try
            //{
            //Bitmap loBMP = new Bitmap(File.InputStream);
            ImageFormat loFormat = loBMP.RawFormat;

            decimal lnRatio = (decimal)loBMP.Width / loBMP.Height;
            decimal tnRatio = (decimal)lnWidth / lnHeight;
            int lnNewWidth = 0;
            int lnNewHeight = 0;

            //*** If the image is smaller than a thumbnail just return it
            //if (loBMP.Width < lnWidth && loBMP.Height < lnHeight)
            //    return loBMP;


            if (lnRatio < tnRatio)
            {
                lnNewWidth = lnWidth;
                decimal lnTemp = lnNewWidth / lnRatio;
                lnNewHeight = (int)lnTemp;
            }
            else
            {
                lnNewHeight = lnHeight;
                decimal lnTemp = lnNewHeight * lnRatio;
                lnNewWidth = (int)lnTemp;
            }

            // System.Drawing.Image imgOut =
            //      loBMP.GetThumbnailImage(lnNewWidth,lnNewHeight,
            //                              null,IntPtr.Zero);

            // *** This code creates cleaner (though bigger) thumbnails and properly
            // *** and handles GIF files better by generating a white background for
            // *** transparent images (as opposed to black)
            bmpOut = new Bitmap(lnWidth, lnHeight);
            Graphics g = Graphics.FromImage(bmpOut);
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
            g.FillRectangle(Brushes.White, 0, 0, lnWidth, lnHeight);
            int x = (lnWidth - lnNewWidth) / 2;
            int y = (lnHeight - lnNewHeight) / 2;
            g.DrawImage(loBMP, x, y, lnNewWidth, lnNewHeight);

            loBMP.Dispose();
            //}
            //catch
            //{
            //    return null;
            //}

            return bmpOut;
        }


        /// <summary>
        /// Proprietà
        /// </summary>
        /// 
        private Boolean disposed = false;

        private int _pk;

        public int Pk
        {
            get { return _pk; }
            set { _pk = value; }
        }

        private string _opath;

        public string Opath
        {
            get { return _opath; }
            set { _opath = value; }
        }

        private Bitmap _bmpData;

        public Bitmap BmpData
        {
            get { return _bmpData; }
            set { _bmpData = value; }
        }

        private int _width;

        public int Width
        {
            get { return _width; }
            set { _width = value; }
        }

        private int _height;

        public int Height
        {
            get { return _height; }
            set { _height = value; }
        }

        public Int64 OdateTicks { get; set; }
    }
}