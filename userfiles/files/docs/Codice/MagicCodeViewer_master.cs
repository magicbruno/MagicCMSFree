using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.IO;

public partial class Temi_MagicCodeViewer : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
		int pk = 0;
		int.TryParse(Request["p"], out pk);
		string TitoloBase = PageTitle.Text;

		if (pk > 0)
		{
			if (TitoloBase != "")
				TitoloBase += " - ";
			// Inserimento titolo pagina
			MagicPost mp = new MagicPost(pk);
			PageTitle.Text = TitoloBase + mp.Titolo;
			string filepath = Server.MapPath(mp.Url);
			FileInfo fi = new FileInfo(filepath);
			if (fi.Exists)
			{
				string ext = fi.Extension.Remove(0, 1);
				StreamReader sr = fi.OpenText();
				//FileStream fs = new FileStream(filepath, FileMode.Open);
				//File.ReadAllText(filepath, System.Text.Encoding.
				string content = sr.ReadToEnd();
				HtmlGenericControl pre = new HtmlGenericControl("pre");
				pre.Attributes["class"] = ext;
				pre.InnerText = content;
				Panel_code.Controls.Add(pre);
			}
		}
		else
		{

		}

		//memorizzazione pk pagina per facilitare lettura da Javascript
		HiddenField_postId.Value = pk.ToString();

    }
}
