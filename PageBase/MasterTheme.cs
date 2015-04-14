using MagicCMS.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.HtmlControls;

namespace MagicCMS.PageBase
{
    public abstract partial class MasterTheme : SiteMasterBase
    {

        public string ErrorTitle { get; set; }
        public string ErrorMessage { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (CmsConfig == null)
                CmsConfig = new CMS_Config();
            if (TheTitle == null)
                TheTitle = CmsConfig.SiteName;

            SiteMasterBase MyMaster = this.Master as SiteMasterBase;
            MyMaster.ThePost = this.ThePost;
            MyMaster.TheTitle = this.TheTitle;
            MyMaster.CmsConfig = this.CmsConfig;
            MyMaster.Keywords = this.Keywords;
            MyMaster.Description = this.Description;
            MyMaster.PageImage = this.PageImage;
        }

        /// <summary>
        /// Crea un oggetto ul con le appropriate class i per creare un menù con drpdown
        /// </summary>
        /// <param name="menuId">Id del menù da rappresentare</param>
        /// <param name="mainClass">La classe della ul principale</param>
        /// <param name="dropdownClass">La classe che indica un ul di tipo drop down</param>
        /// <param name="dropDownParentClass">La classe che contrassegna un elemento li che contiene un drop down nella barra menù</param>
        /// <param name="submenuParentClass">La classe che contrassegna un elemento li contenuto in una drop down che contiene un submenu drop down</param>
        /// <param name="activeClass">La classe she indica se l'elemento li è attivo (se indica la pagina corrente)</param>
        /// <param name="level">Deve essere sempre 0 nello sviluppo ricorsi indica se si tratta di menu bar o submenu</param>
        /// <returns></returns>
        protected HtmlGenericControl AggiungiVoci(int menuId, string mainClass, string dropdownClass, string dropDownParentClass,
                                                  string submenuParentClass, string activeClass, int level)
        {
            // adattamento al menu bootstrap
            HtmlGenericControl ul = new HtmlGenericControl("ul");
            ul.Attributes["class"] = mainClass;
            MagicPost mp = new MagicPost(menuId);
            // Elemeti puntati dal menu
            MagicPostCollection mpc = mp.GetChildren(mp.ExtraInfo, -1);

            //id della pagina corrente
            int p;
            int.TryParse(Request["p"], out p);
            if (CmsConfig == null)
                CmsConfig = new CMS_Config();

            foreach (MagicPost post in mpc)
            {
                //titolo e link di default
                string titolo_val = "",
                        link_val = Request.Url.LocalPath + "?p=" + post.Pk.ToString(),
                        iconClass = post.IconClass.Trim();

                //se Titolo è impostato usa Titolo per il testo della voce del menù
                HtmlGenericControl li = new HtmlGenericControl("li");
                HtmlAnchor a = new HtmlAnchor();

                if (!String.IsNullOrEmpty(iconClass))
                    titolo_val = "<i class=\"fa " + iconClass + "\"></i> ";

                titolo_val += post.Title_RT;

                if (post.Pk == p)
                    li.Attributes["class"] = activeClass;

                a.HRef = Request.Url.LocalPath + "?p=" + post.Pk.ToString();
                switch (post.Tipo)
                {
                    case MagicPostTypeInfo.Menu:
                    case MagicPostTypeInfo.LinkFalso:
                        a.HRef = "javascript:;";
                        break;
                    case MagicPostTypeInfo.CollegamentoInternet:
                        //a.HRef = post.Url;
                        a.Target = "_blank";
                        a.Attributes["class"] = post.ExtraInfo;
                        if (!string.IsNullOrEmpty(post.TestoBreve_RT))
                            a.Attributes["title"] = post.TestoBreve_RT;
                        break;
                    case MagicPostTypeInfo.CollegamentoInterno:
                        //int linkPk;
                        //if (int.TryParse(post.ExtraInfo, out linkPk))
                        //    a.HRef = Request.Url.LocalPath + "?p=" + post.ExtraInfo;
                        //else
                        //    a.HRef = post.Url;
                        if (!string.IsNullOrEmpty(post.TestoBreve_RT))
                            a.Attributes["title"] = post.TestoBreve_RT;
                        break;
                    case MagicPostTypeInfo.ButtonLanguage:
                        if (!String.IsNullOrEmpty(post.Url2) && String.IsNullOrEmpty(post.ExtraInfo1))
                            titolo_val = "";
                        string query = "?";
                        foreach (string key in Request.QueryString)
                        {
                            if (key != "lang")
                                query += key + "=" + Request.QueryString[key];
                        }
                        a.HRef = Request.Url.AbsolutePath + query + (query != "?" ? "&" : "") + "lang=" + post.ExtraInfo;
                        if (!string.IsNullOrEmpty(post.ExtraInfo2))
                            a.Attributes["class"] = post.ExtraInfo2;
                        break;
                    default:
                        if (CmsConfig.SinglePage)
                            a.HRef = "#section_" + post.Pk.ToString();
                        else
                            a.HRef = Request.Url.LocalPath + "?p=" + post.Pk.ToString();
                        break;
                }

                if (post.Url2 != "" && (post.Tipo == MagicPostTypeInfo.CollegamentoInterno || post.Tipo == MagicPostTypeInfo.ButtonLanguage))
                {
                    HtmlImage img = new HtmlImage();
                    img.Src = post.Url2;
                    a.Controls.Add(img);
                    a.Title = post.Title_RT;
                }
                else
                {
                    a.InnerHtml = titolo_val;
                    if (!String.IsNullOrEmpty(post.TestoBreve))
                    {
                        //a.Title = post.TestoBreve;
                    }
                }

                li.Controls.Add(a);
                a.Attributes["data-pk"] = post.Pk.ToString();

                if (post.Tipo == MagicPostTypeInfo.Menu)
                {
                    a.Attributes["class"] = "dropdown-toggle";
                    a.Attributes["data-toggle"] = "dropdown";
                    HtmlGenericControl submenu = AggiungiVoci(post.Pk, dropdownClass, dropdownClass, dropDownParentClass, submenuParentClass, activeClass, level + 1);
                    if (level == 0)
                        li.Attributes["class"] = dropDownParentClass;
                    else
                        li.Attributes["class"] = submenuParentClass;
                    li.Controls.Add(submenu);
                }
                if (Request["p"] == post.Pk.ToString())
                    a.Attributes["class"] += " active";
                ul.Controls.Add(li);
            }
            return ul;
        }

        protected HtmlGenericControl AggiungiVoci(int menuId, string cssClass)
        {
            return AggiungiVoci(menuId, cssClass, "submenu", "", "", "", 0);
        }


    }
}