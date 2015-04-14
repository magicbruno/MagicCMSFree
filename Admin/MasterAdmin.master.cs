﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MagicCMS.Core;
using System.Web.UI.HtmlControls;
using System.IO;

namespace MagicCMS.Admin
{
    public partial class MasterAdmin : System.Web.UI.MasterPage
    {
        public int Types { get; set; }
        public string UserName { get; set; }
        public string UserRole { get; set; }
        public int Users { get; set; }

        public int PageType { get; set; }
        public int Pk { get; set; }
        public int PageParent { get; set; }
        public string Filename { get; set; }

        protected void LinkButton_allowedTypes_Click(object sender, EventArgs e)
        {
            MagicSession.Current.ShowInactiveTypes = !MagicSession.Current.ShowInactiveTypes;
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        protected void LinkButton_logout_Click(object sender, EventArgs e)
        {
            MagicSession.Current.LoggedUser = new MagicUser();
            Response.Redirect("/Admin");
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            int pk = 0, type = 0, parent = 0;
            int.TryParse(Request["pk"], out pk);
            int.TryParse(Request["type"], out type);
            int.TryParse(Request["parent"], out parent);
            Pk = pk;
            PageType = type;
            PageParent = parent;
            Filename = Path.GetFileName(Request.Path);

            sitename.InnerHtml = Request.Url.Host;

            // Controllo se l'utente è loggato
            if (MagicSession.Current.LoggedUser.Level < 4)
            {
                MagicSession.Current.LastAccessTry = Request.Url.PathAndQuery;
                Response.Redirect("login.aspx");
            }

            // Usern name and role 
            UserName = String.IsNullOrEmpty(MagicSession.Current.LoggedUser.Name) ? MagicSession.Current.LoggedUser.Email : MagicSession.Current.LoggedUser.Name;
            UserRole = MagicSession.Current.LoggedUser.LevelDescription;
            Users = MagicUser.RecordCount();
            Types = MagicPostTypeInfo.RecordCount();

            // FileBrowser prerogatives
            MB.FileBrowser.MagicSession.Current.AllowedFileTypes = MagicCMSConfiguration.GetConfig().AllowedFileTypes;
            MB.FileBrowser.MagicSession.Current.FileBrowserAccessMode = IZ.WebFileManager.AccessMode.Delete;

            //CheckPrerogatives(this);

            // Insert menu config
            if (MagicSession.Current.ShowInactiveTypes)
                LinkButton_allowedTypes.Text = "<i class=\"fa fa-minus-circle text-red\"></i>Consenti solo tipi di pagine attivi";
            else
                LinkButton_allowedTypes.Text = "<i class=\"fa fa-unlock text-green\"></i>Consenti tutti i tipi di pagine";

            // If not administrator menu insert defaults to "Only Predefined Page Types Allowed"
            if (MagicSession.Current.LoggedUser.Level < 10)
            {
                LinkButton_allowedTypes.Visible = false;
                MagicSession.Current.ShowInactiveTypes = false;
            }
            Boolean onlyActive = (!MagicSession.Current.ShowInactiveTypes && (MagicSession.Current.LoggedUser.Level >= 10));
            MagicPostTypeInfoCollection pageTypes = new MagicPostTypeInfoCollection(onlyActive, MagicPostTypeInfoOrder.Alpha);
            foreach (MagicPostTypeInfo mpti in pageTypes)
            {
                HtmlGenericControl li = new HtmlGenericControl("li");
                li.InnerHtml = "<a href=\"" + "editcontents.aspx?type=" + mpti.Pk.ToString() + "\"><i class=\"fa " + mpti.Icon + "\"></i>" + mpti.Nome + "</a>";
                //li.Value = "editcontents.aspx?type=" + mpti.Pk.ToString();
                if (mpti.FlagContenitore)
                    BL_containers.Controls.Add(li);
                else
                    BL_content.Controls.Add(li);
                if (PageParent == 0 && Pk == 0 && PageType == mpti.Pk)
                {
                    li.Attributes["class"] = "active";
                }
            }
        }

        /// <summary>
        /// Determines whether the specified menu item is active.
        /// </summary> 
        /// <param name="menuItem">The menu item.</param>
        /// <returns>"active" if menuitem is active otherwise ""</returns>
        public string isActive(string href)
        {
            string ret = "";

            if (href.IndexOf(Filename) > -1)
            {
                // pagina che utilizza editcontents.aspx
                if (Filename.IndexOf("editcontents") > -1)
                {

                    if (PageType == 0 && PageParent == 0)
                    {
                        ret = "active";
                    }
                }
                else
                {
                    ret = "active";
                }
            }

            return ret;
        }

        public string hasPrerogative(int level)
        {
            string ret = "";
            if (level < MagicSession.Current.LoggedUser.Level)
                ret = "hidden";

            return ret;
        }

        private void CheckPrerogatives(Control c)
        {
            if (c is HtmlGenericControl)
            {
                HtmlGenericControl k = c as HtmlGenericControl;
                if (!String.IsNullOrEmpty(k.Attributes["data-prerogatives"]))
                {
                    int level;
                    int.TryParse(k.Attributes["data-prerogatives"], out level);
                    if (level > MagicSession.Current.LoggedUser.Level)
                        k.Visible = false;
                }
            }
            if (c.HasControls())
            {
                foreach (Control item in c.Controls)
                {
                    CheckPrerogatives(item);
                }
            }
        }
    }
}