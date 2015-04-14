 ////////////////////////////////////////////////////////////////////////////////////////////////////
/// @file   MagicCMS\MagicCMSConfiguration.cs
///
/// @brief  Implements the magic CMS configuration class.
////////////////////////////////////////////////////////////////////////////////////////////////////

using System.Configuration;

/// <summary>
/// Gestisce la configurazione personalizzata di MagicCMS
/// </summary>
/// 
namespace MagicCMS.Core
{
    /// <summary>
    /// Wrap Class for MagicCMSConfiguration Configuration Section
    /// </summary>
    public class MagicCMSConfiguration : ConfigurationSection
    {
        public MagicCMSConfiguration()
        {
        }

        /// <summary>
        /// Database Connection Name
        /// </summary>
        [ConfigurationProperty("ConnectionName", IsRequired = true)]
        public string ConnectionName
        {
            get { return this["ConnectionName"] as string; }
        }

        /// <summary>
        /// Path of the MagicTheme.master file
        /// </summary>
        [ConfigurationProperty("ThemePath", IsRequired = true)]
        public string ThemePath
        {
            get { return this["ThemePath"] as string; }
        }

        /// <summary>
        /// Path of the default MagicTheme.master file
        /// </summary>
        [ConfigurationProperty("DefaultThemePath", IsRequired = true)]
        public string DefaultThemePath
        {
            get { return this["DefaultThemePath"] as string; }
        }

        [ConfigurationProperty("DefaultContentMaster", IsRequired = true)]
        public string DefaultContentMaster
        {
            get { return this["DefaultContentMaster"] as string; }
        }

        [ConfigurationProperty("smtpServerName", DefaultValue = "smtp.magicbusmultimedia.it", IsRequired = false)]
        public string SmtpServerName
        {
            get { return this["smtpServerName"] as string; }
        }

        [ConfigurationProperty("smtpUsername", DefaultValue = "username", IsRequired = false)]
        public string SmtpUserName
        {
            get { return this["smtpUsername"] as string; }
        }

        [ConfigurationProperty("smtpPassword", DefaultValue = "password", IsRequired = false)]
        public string SmtpPassword
        {
            get { return this["smtpPassword"] as string; }
        }

        [ConfigurationProperty("smtpDefaultFromMail", DefaultValue = "", IsRequired = false)]
        public string SmtpDefaultFromMail
        {
            get { return this["smtpDefaultFromMail"] as string; }
        }

        [ConfigurationProperty("smtpAdminMail", DefaultValue = "", IsRequired = false)]
        public string SmtpAdminMail
        {
            get { return this["smtpAdminMail"] as string; }
        }

        [ConfigurationProperty("defaultImage", DefaultValue = "", IsRequired = false)]
        public string DefaultImage
        {
            get { return this["defaultImage"] as string; }
        }

        [ConfigurationProperty("indexTypes", DefaultValue = "", IsRequired = false)]
        public string IndexTypes
        {
            get { return this["indexTypes"] as string; }
        }

        [ConfigurationProperty("indexField", DefaultValue = "", IsRequired = false)]
        public string IndexField
        {
            get { return this["indexField"] as string; }
        }

        [ConfigurationProperty("imagesPath", DefaultValue = "/db_images/", IsRequired = false)]
        public string ImagesPath
        {
            get { return this["imagesPath"] as string; }
        }

        [ConfigurationProperty("allowedFileTypes", DefaultValue = "", IsRequired = false)]
        public string AllowedFileTypes
        {
            get
            {
                return this["allowedFileTypes"] as string;
            }
        }

        [ConfigurationProperty("testoBreveDefLength", DefaultValue = 300, IsRequired = true)]
        public int TestoBreveDefLenfth
        {
            get
            {
                return (int)this["testoBreveDefLength"];
            }
        }

        public static MagicCMSConfiguration GetConfig()
        {
            //return ConfigurationSettings.GetConfig("MagicCMSConfigSection") as MagicCMSConfiguration;
            return System.Web.Configuration.WebConfigurationManager.GetSection("MagicCMSConfigSection") as MagicCMSConfiguration;

        }

    }
}