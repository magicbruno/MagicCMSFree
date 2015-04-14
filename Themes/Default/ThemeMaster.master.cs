using MagicCMS.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace MagicCMS.Themes.Default
{
    public partial class ThemeMaster : MagicCMS.PageBase.MasterTheme
    {
        new protected void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            //int p;

            //int.TryParse(Request["p"], out p);

            // Main menu
            int rootmenuId = (CmsConfig.MainMenu != 0) ? CmsConfig.MainMenu : MagicPost.GetMainMenu();
            if (rootmenuId > 0)
            {
                HtmlGenericControl menubar = AggiungiVoci(rootmenuId, "nav navbar-nav", "dropdown-menu", "dropdown parent", "dropdown-submenu parent", "active", 0);
                Menu.Controls.Add(menubar);
            }

            // Menù secondario
            //int secondaryMenu = (CmsConfig.SecondaryMenu != 0 ? CmsConfig.SecondaryMenu : MagicPost.GetSecondaryMenu());
            //if (secondaryMenu > 0)
            //{
            //    HtmlGenericControl menusecondary = AggiungiVoci(secondaryMenu, "nav accordmobile pull-right", "dropdown-menu", "dropdown parent", "dropdown-submenu parent", "active", 0);
            //    Menu_Secondario.Controls.Add(menusecondary);
            //}

            //// Menù speciale
            //int specialMenu = MagicPost.GetSpecialItem(MagicPostTypeInfo.Menu, "menù speciale", 2000);
            //if (specialMenu > 0)
            //{
            //    HtmlGenericControl menuspeciale = AggiungiVoci(specialMenu, "mb-special-menu");
            //    Menu_speciale.Controls.Add(menuspeciale);
            //}
        }
    }
}