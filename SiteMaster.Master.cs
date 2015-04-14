﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using MagicCMS.Core;
using System.Reflection;
using System.Diagnostics;
using System.IO;

namespace MagicCMS
{
    public partial class SiteMaster : MagicCMS.PageBase.SiteMasterBase
    {
        public string jQueryVersion { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            // Language handling

            string lang = Request.QueryString["lang"];
            if (!String.IsNullOrEmpty(lang))
            {
                MagicSession.Current.CurrentLanguage = lang;
            }
            if (CmsConfig == null)
                CmsConfig = new CMS_Config();
            if (TheTitle == null)
                TheTitle = CmsConfig.SiteName;

            // Browser
            System.Web.HttpBrowserCapabilities browser = Request.Browser;
            string defLang = (MagicSession.Current.CurrentLanguage == "default") ? CmsConfig.TransSourceLangId : MagicSession.Current.CurrentLanguage;
            theDocument.Attributes["lang"] = defLang;
            string documentClass = "no-js " + defLang;
            jQueryVersion = "2.1.3";
            if (browser.Browser == "IE" || browser.Browser == "InternetExplorer")
            {
                switch (browser.MajorVersion)
                {
                    case 7:
                        documentClass += " ie7 lt-ie9 lt-ie8 lt-ie10 lt-ie11";
                        break;
                    case 8:
                        documentClass += " ie8 lt-ie9 lt-ie10 lt-ie11";
                        break;
                    case 9:
                        documentClass += " ie9 lt-ie10 lt-ie11";
                        break;
                    case 10:
                        documentClass += " ie10 lt-ie11";
                        break;
                    case 11:
                        documentClass += " ie11";
                        break;
                    default:
                        if (browser.MajorVersion > 7)
                            documentClass += " ie" + browser.MajorVersion.ToString();
                        else
                            documentClass += " lt-ie7 lt-ie9 lt-ie8 lt-ie10 lt-ie11"; 
                        break;
                }
                if (browser.MajorVersion < 9)
                    jQueryVersion = "1.11.2";

            }

            /**
             * Adding proper META tags
             * */
            //Genarator
            HtmlMeta version = new HtmlMeta();
            version.Name = "generator";
            AssemblyName assembly = Assembly.GetExecutingAssembly().GetName();

            version.Content = String.Format("Magic CMS {0}.{1}", assembly.Version.Major, assembly.Version.Minor);
            head.Controls.AddAt(0,version);

            // Keywords
            HtmlMeta keys = new HtmlMeta();
            keys.Name = "keywords";
            keys.Content = Keywords;
            head.Controls.AddAt(0,keys);

            //Description
            HtmlMeta desc = new HtmlMeta();
            desc.Name = "description";
            desc.Content = Description;
            head.Controls.AddAt(0,desc);

            //Facebook Open Graph properties
            HtmlMeta fb_title = new HtmlMeta();
            fb_title.Attributes.Add("property", "og:title");
            fb_title.Content = TheTitle;
            head.Controls.AddAt(0, fb_title);

            HtmlMeta fb_type = new HtmlMeta();
            fb_type.Attributes["property"] = "og:type";
            fb_type.Content = "website";
            head.Controls.AddAt(0, fb_type);

            HtmlMeta fb_image = new HtmlMeta();
            fb_image.Attributes["property"] = "og:image";
            fb_image.Content = (!String.IsNullOrEmpty(PageImage) ? PageImage : CmsConfig.DefaultImage);
            head.Controls.AddAt(0, fb_image);

            HtmlMeta fb_url = new HtmlMeta();
            fb_url.Attributes["property"] = "og:url";
            fb_url.Content = Request.Url.AbsoluteUri;
            head.Controls.AddAt(0, fb_url);

            /**
             * Touch icons and favicon
             * */
            //apple
            string[] sizes = new string[] { "57x57", "72x72", "76x76", "114x114", "120x120", "144x144", "152x152", "180x180" };
            int i = 0;
            while (i < sizes.Length)
            {
                string filename = Server.MapPath(CmsConfig.ImagesPath + "apple-touch-icon-" + sizes[i] + "-precomposed.png");
                if (File.Exists(filename))
                {
                    HtmlLink touchIcon = new HtmlLink();
                    touchIcon.Attributes.Add("rel", "apple-touch-icon-precomposed");
                    touchIcon.Attributes.Add("sizes", sizes [i]);
                    touchIcon.Href = CmsConfig.ImagesPath + "apple-touch-icon-" + sizes[i] + "-precomposed.png";
                    head.Controls.AddAt(0, touchIcon);
                }
                i++;
            }

            //Android Google
            if (File.Exists(Server.MapPath(CmsConfig.ImagesPath + "touch-icon-192x192.png")))
            {
                HtmlLink touchIcon = new HtmlLink();
                touchIcon.Attributes.Add("rel", "icon");
                touchIcon.Attributes.Add("sizes", "192x192");
                touchIcon.Href = CmsConfig.ImagesPath + "touch-icon-192x192.png";
                head.Controls.AddAt(0, touchIcon);
            }

            //Favicon
            if (File.Exists(Server.MapPath(CmsConfig.ImagesPath + "favicon.png")))
            {
                HtmlLink touchIcon = new HtmlLink();
                touchIcon.Attributes.Add("rel", "shortcut icon");
                touchIcon.Href = CmsConfig.ImagesPath + "favicon.png";
                head.Controls.AddAt(0, touchIcon);
            }

            if (!String.IsNullOrEmpty(CmsConfig.GaProperty_ID))
            {
                Literal ga = new Literal();
                ga.Text =   "<!-- Google analytics -->\n" +
                            " <script> \n" +
                            "         (function (i, s, o, g, r, a, m) { \n" +
                            "             i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () { \n" +
                            "                 (i[r].q = i[r].q || []).push(arguments) \n" +
                            "             }, i[r].l = 1 * new Date(); a = s.createElement(o), \n" +
                            "             m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m) \n" +
                            "         })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga'); \n" +
                            "  \n" +
                            "         ga('create', '" + CmsConfig.GaProperty_ID + "', 'auto'); \n" +
                            "         ga('send', 'pageview'); \n" +
                            " </script> \n";
                Scripts.Controls.Add(ga);
            }


        }
    }
}