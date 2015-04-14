using MagicCMS.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MagicCMS.Admin
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Button_submit_Click(object sender, EventArgs e)
        {
            MagicUser user = new MagicUser(email.Text, password.Text);
            if (user.LoginResult == MbUserLoginResult.Success)
            {
                MagicSession.Current.LoggedUser = user;
                MagicSession.Current.SessionStart = DateTime.Now;
                if (!String.IsNullOrEmpty(MagicSession.Current.LastAccessTry))
                    Response.Redirect(MagicSession.Current.LastAccessTry);
                else
                    Response.Redirect("/Admin");
            }
            else
            {
                Response.Redirect(Request.Url.AbsoluteUri);
            }
        }
    }
}