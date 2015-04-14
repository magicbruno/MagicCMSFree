using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MagicCMS.Core;
using System.IO;

namespace MagicCMS.PageBase
{
    public partial class MagicPage : System.Web.UI.Page
    {
        public MagicPost ThePost { get; set; }
        public CMS_Config Config { get; set; }

        /// <summary>
        /// Handles the PreInit event of the Page control.
        /// Set language. Load Proper Master Pagerect and if in case redirect to home page.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void Page_PreInit(object sender, EventArgs e)
        {
            int p;
            string lang = Request["lang"];

            // Settin language
            if (!String.IsNullOrEmpty(lang))
                MagicSession.Current.CurrentLanguage = lang;

            // Par p is number?
            Boolean notNullPar = int.TryParse(Request["p"], out p);

            //Load theme config setting
            Config = new CMS_Config();

            // If main page is called with no par load home page
            if (p == 0)
            {
                if (Path.GetFileName(Request.Url.LocalPath) == "Contenuti.aspx" || Path.GetFileName(Request.Url.LocalPath) == "")
                    p = (Config.StartPage > 0 ? Config.StartPage : MagicPost.GetSpecialItem(MagicPostTypeInfo.HomePage));
            }
            // Create post object
            ThePost = new MagicPost(p);


            if (ThePost.Pk > 0) {
                //Current language
                string currentLang = MagicSession.Current.CurrentLanguage;

                // Is language setting pessimistic (show only tranlated objects) or optimistic (show not translate object
                // in original - source - language)
                Boolean onlyIfTranslated = MagicSession.Current.TransAutoHide;

                // If pessimistic redirect to home page if page is not translated
                if (currentLang != "default" && onlyIfTranslated)
                {
                    MagicTranslation mt = ThePost.Translations.GetByLangId(currentLang);
                    if (mt == null)
                        Response.Redirect("/");
                }

                // Load proper Master Page according to the page type
                switch (ThePost.Tipo)
                {
                    // Page types that must be redirected to other resources
                    case MagicPostTypeInfo.CollegamentoInternet:
                        Response.Redirect(ThePost.Url);
                        break;
                    case MagicPostTypeInfo.CollegamentoInterno:
                        int tipo = 0, tag_id = 0;
                        int.TryParse(ThePost.ExtraInfo2, out tipo);
                        int.TryParse(ThePost.ExtraInfo3, out tag_id);
                        if (ThePost.ExtraInfo.ToUpper() == "AUTO" && tipo > 0)
                        {
                            int page_id = MagicPost.GetSpecialItem(tipo, tag_id, MagicOrdinamento.DateDesc);
                            Response.Redirect(Request.Url.AbsolutePath + "?p=" + page_id.ToString() + "&cat=" + tag_id.ToString() +
                                ((!String.IsNullOrEmpty(ThePost.ExtraInfo4)) ? "&cat=" + ThePost.ExtraInfo4 : ""));
                        }
                        else if (!String.IsNullOrEmpty(ThePost.ExtraInfo))
                            Response.Redirect(Request.Url.AbsolutePath + "?p=" + ThePost.ExtraInfo);
                        else
                            Response.Redirect(ThePost.Url);
                        break;

                    case MagicPostTypeInfo.DocumentoScaricabile:
                        Response.Redirect(ThePost.Url);
                        break;

                    default:
                        // Try to load type specific master page
                        if (LoadMaster(ThePost.TypeInfo.MasterPageFile))
                        {
                            MagicCMS.PageBase.MasterTheme myMaster = Master as MagicCMS.PageBase.MasterTheme;
                            myMaster.ThePost = ThePost;
                            myMaster.TheTitle = ThePost.Title_RT;
                            myMaster.CmsConfig = Config;
                            myMaster.Keywords = ThePost.Tags;
                            myMaster.Description = ThePost.TestoBreve_RT;
                        }
                        // Else try to load default error master page and throws an error
                        else if (LoadMaster(MagicCMSConfiguration.GetConfig().DefaultContentMaster))
                        {
                            MagicCMS.PageBase.MasterTheme myMaster = Master as MagicCMS.PageBase.MasterTheme;
                            myMaster.TheTitle = Config.SiteName;
                            myMaster.ErrorTitle = "La pagina non esiste";
                            myMaster.ErrorMessage = "Risorsa non visualizzabile.";
                        };
                        break;
                }            
            }
            // Not existing paramete error
            else if (notNullPar && LoadMaster(MagicCMSConfiguration.GetConfig().DefaultContentMaster))
            {
                MagicCMS.PageBase.MasterTheme myMaster = Master as MagicCMS.PageBase.MasterTheme;
                myMaster.TheTitle = Config.SiteName;
                myMaster.ErrorTitle = "La pagina non esiste";
                myMaster.ErrorMessage ="Parametro errato";
            }
        }


        /// <summary>
        /// Loads the master.
        /// </summary>
        /// <param name="MasterFile">The master file.</param>
        /// <returns>True if file was loded, false if it doesn't exist</returns>
        protected Boolean LoadMaster(string MasterFile)
        {
            string themePath = Config.ThemePath.TrimEnd(new char[] { '/' }) + "/" + MasterFile;
            if (File.Exists(Server.MapPath(themePath)))
            {
                this.MasterPageFile = themePath;
                return true;
            }
            return false;
        }

    }
}