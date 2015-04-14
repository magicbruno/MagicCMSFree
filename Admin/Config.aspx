﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterAdmin.master" AutoEventWireup="true"
    CodeBehind="Config.aspx.cs" Inherits="MagicCMS.Admin.Config" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeaderContent" runat="server">
    <h1><i class="fa fa-cogs"></i>Configurazione</h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="box box-primary">
                <div class="box-header">
                    <h3 class="box-title">Lingue disponibili per le traduzioni</h3>
                    <div class="box-tools pull-right">
                        <%--                        <a href="#modal-edit-user" data-toggle="modal" data-rowpk="0" class="btn btn-sm bg-olive">
                            <i class="fa fa-user"></i>nuovo utente</a>--%>
                        <button type="button" class="btn btn-primary btn-sm" data-widget="collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body">
                    <table id="table-lang" class="table table-striped table-bordered" cellspacing="0"
                        width="100%">
                        <thead>
                            <tr>
                                <th>Id</th>
                                <th>Lingua</th>
                                <th><i class="fa fa-check"></i></th>
                                <th title="Nascondi elementi non tradotti">Autohide</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="col-md-12">
            <div class="box box-primary" id="edit-record">
                <div class="box-header">
                    <h3 class="box-title">Configurazione</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-primary btn-sm" data-widget="collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="form-horizontal" role="form" data-ride="mb-form" data-action="Ajax/Edit.ashx"
                        id="edit-config">
                        <fieldset>
                            <input type="hidden" id="Pk" name="Pk" value="0" />
                            <input type="hidden" id="table" name="table" value="CONFIG" />
                            <div class="form-group" id="fg_SiteName">
                                <label for="SiteName" class="col-sm-2 control-label">Nome sito</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="SiteName" value="<% = CMS_config.SiteName %>" />
                                </div>
                            </div>
                            <div class="form-group" id="fg-start">
                                <label for="" class="col-sm-2 control-label">Pagina iniziale</label>
                                <div class="col-sm-10">
                                    <input type="hidden" value="<% = (CMS_config.StartPage > 0 ? CMS_config.StartPage.ToString() : "") %>"
                                        id="StartPage" class="form-control"
                                        data-types="<% = String.Join(",", StartPageList.ToArray()) %>" data-placeholder="Pagina iniziale" />
                                </div>
                            </div>
                            <div class="form-group" id="fg-nav">
                                <label for="" class="col-sm-2 control-label">Menù</label>
                                <div class="col-sm-10">
                                    <div class="row">
                                        <div class="col-sm-4">
                                            <input type="hidden" value="<% = (CMS_config.MainMenu > 0 ? CMS_config.MainMenu.ToString() : "") %>"
                                                id="MainMenu" class="form-control"
                                                data-types="<% = MagicCMS.Core.MagicPostTypeInfo.Menu.ToString() %>" data-placeholder="Menù principale" />
                                        </div>
                                        <div class="col-sm-4">
                                            <input type="hidden" value="<% = (CMS_config.SecondaryMenu > 0 ? CMS_config.SecondaryMenu.ToString() : "") %>"
                                                id="SecondaryMenu"
                                                class="form-control"
                                                data-types="<% = MagicCMS.Core.MagicPostTypeInfo.Menu.ToString() %>" data-placeholder="Menù secondario" />
                                        </div>
                                        <div class="col-sm-4">
                                            <input type="hidden" value="<% = (CMS_config.FooterMenu > 0 ? CMS_config.FooterMenu.ToString() : "")%>"
                                                id="FooterMenu" class="form-control"
                                                data-types="<% = MagicCMS.Core.MagicPostTypeInfo.Menu.ToString() %>" data-placeholder="Terzo menù" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group" id="fg-flags">
                                <label for="" class="col-sm-2 control-label">flags</label>
                                <div class="col-sm-10">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <label>
                                                <input type="checkbox" value="true" class="minimal" id="SinglePage" <% = CMS_config.SinglePage ? "checked" : "" %> />
                                                Pagina Singola
                                            </label>
                                        </div>
                                        <div class="col-sm-3">
                                            <label title="Contenitore">
                                                <input type="checkbox" value="true" class="minimal" id="MultiPage" <% = CMS_config.MultiPage ? "checked" : "" %> />
                                                Pagina Multipla
                                            </label>
                                        </div>
                                        <div class="col-sm-3">
                                            <label title="Bottone cerca sul server...">
                                                <input type="checkbox" value="true" class="minimal" id="TransAuto" <% = CMS_config.TransAuto ? "checked" : "" %> />
                                                Traduttore auto
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group" id="fg-testo-breve">
                                <label for="TransClientId" class="col-sm-2 control-label">ClientId per Bing Translator</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="TransClientId" value="<% = CMS_config.TransClientId %>" />
                                </div>
                            </div>
                            <div class="form-group" id="fg-LabelTestoBreve">
                                <label for="TransSecretKey" class="col-sm-2 control-label">Secret Key per Bing Translator</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="TransSecretKey" value="<% = CMS_config.TransSecretKey %>" />
                                </div>
                            </div>
                            <div class="form-group" id="fg-TransSourceLangId">
                                <label for="TransSourceLangId" class="col-sm-2 control-label">Lingua di origine</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="TransSourceLangId" value="<% = CMS_config.TransSourceLangId %>" />
                                </div>
                            </div>
                            <div class="form-group" id="fg-TransSourceLangName">
                                <label for="TransSourceLangName" class="col-sm-2 control-label">Nome lingua di origine</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="TransSourceLangName" value="<% = CMS_config.TransSourceLangName %>" />
                                </div>
                            </div>
                            <div class="form-group" id="fg-ThemePath">
                                <label for="ThemePath" class="col-sm-2 control-label">Cartella del tema</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="ThemePath" value="<% = CMS_config.ThemePath %>" />
                                </div>
                            </div>
                            <div class="form-group" id="fg-DefaultContentMaster">
                                <label for="DefaultContentMaster" class="col-sm-2 control-label">Pagina master di default</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="DefaultContentMaster" value="<% = CMS_config.DefaultContentMaster %>" />
                                </div>
                            </div>
                            <div class="form-group" id="fg-ImagesPath">
                                <label for="ImagesPath" class="col-sm-2 control-label">Cartella delle icone</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="ImagesPath" value="<% = CMS_config.ImagesPath %>" />
                                </div>
                            </div>
                            <div class="form-group" id="fg-DefaultImage">
                                <label for="DefaultImage" class="col-sm-2 control-label">Immagine di default</label>
                                <div class="col-sm-10">
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="DefaultImage" value="<% = CMS_config.DefaultImage  %>" />
                                        <span class="input-group-btn">
                                            <button class="btn btn-primary btn-flat " type="button" data-callback="getImageUrl"
                                                title="Sfoglia il server"
                                                data-target="#FileBrowserModal" data-toggle="modal">
                                                <i class="fa fa-search"></i>Sfoglia...</button>
                                            <button class="btn btn-info btn-flat btn-icon" type="button" data-source="#DefaultImage"
                                                title="Guarda il file"
                                                data-target="#LightBox" data-toggle="modal">
                                                <i class="fa fa-search-plus"></i>
                                            </button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group" id="fg-SmtpServer">
                                <label for="SmtpServer" class="col-sm-2 control-label">Server SMTP</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="SmtpServer" value="<% = CMS_config.SmtpServer %>" />
                                </div>
                            </div>
                            <div class="form-group" id="fg-SmtpUsername">
                                <label for="SmtpUsername" class="col-sm-2 control-label">Username SMTP</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="SmtpUsername" value="<% = CMS_config.SmtpUsername %>" />
                                </div>
                            </div>
                            <div class="form-group" id="fg-SmtpPassword">
                                <label for="SmtpPassword" class="col-sm-2 control-label">Password SMTP</label>
                                <div class="col-sm-10">
                                    <input type="password" class="form-control" id="SmtpPassword" value="<% = CMS_config.SmtpPassword %>" />
                                </div>
                            </div>
                            <div class="form-group" id="fg-SmtpDefaultFromMail">
                                <label for="SmtpDefaultFromMail" class="col-sm-2 control-label">Mittente di default</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="SmtpDefaultFromMail" value="<% = CMS_config.SmtpDefaultFromMail %>" />
                                </div>
                            </div>
                            <div class="form-group" id="fg-SmtpAdminMail">
                                <label for="SmtpAdminMail" class="col-sm-2 control-label">Indirizzo Admin</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="SmtpAdminMail" value="<% = CMS_config.SmtpAdminMail %>" />
                                </div>
                            </div>
                            <div class="form-group" id="fg-GaProperty_ID">
                                <label for="GaProperty_ID" class="col-sm-2 control-label">Id Google Analytics</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="GaProperty_ID" value="<% = CMS_config.GaProperty_ID %>"
                                        placeholder="formato: UA-xxxxxxxxx-x" />
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-xs-12">
                                    <div class="center-block text-center">
                                        <button type="button" class="btn btn-primary" data-action="submit">
                                            Salva configurazione</button>
                                        <%-- <button type="button" class="btn btn-danger btn-sm" data-dismiss="record">Elimina</button>--%>
                                    </div>
                                </div>
                            </div>
                            <%-- <div class="alert"></div>--%>
                        </fieldset>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Scripts" runat="server">
    <script>
        function getImageUrl(url) {
            $('#DefaultImage').val(url);
            $('#FileBrowserModal').modal('hide');
        }

        $(function () {
            var $langtable = $('#table-lang')
                .on('xhr.dt', function (e, settings, json) {
                    var xhr = settings.jqXHR;
                    if (xhr.status == 403) {
                        bootbox.alert('Sessione scaduta. È necessario ripetere il login.', function () {
                            window.location.href = "/Admin/Login.aspx";
                        });
                    }
                    //else if (xhr.status != 200)
                    //    bootbox.alert('Si è verificaro un errore: ' + xhr.status + ", " + xhr.statusText);
                })
                .DataTable({
                    "ajax": {
                        "url": "Ajax/LanguagesDT.ashx",
                        "type": "POST"
                    },
                    "language": {
                        "sEmptyTable": "Nessun dato presente nella tabella",
                        "sInfo": "Vista da _START_ a _END_ di _TOTAL_ elementi",
                        "sInfoEmpty": "Vista da 0 a 0 di 0 elementi",
                        "sInfoFiltered": "(filtrati da _MAX_ elementi totali)",
                        "sInfoPostFix": "",
                        "sInfoThousands": ",",
                        "sLengthMenu": "Visualizza _MENU_ elementi",
                        "sLoadingRecords": "Caricamento...",
                        "sProcessing": "Elaborazione...",
                        "sSearch": "Cerca:",
                        "sZeroRecords": "La ricerca non ha portato alcun risultato.",
                        "oPaginate": {
                            "sFirst": "Inizio",
                            "sPrevious": "Precedente",
                            "sNext": "Successivo",
                            "sLast": "Fine"
                        },
                        "oAria": {
                            "sSortAscending": ": attiva per ordinare la colonna in ordine crescente",
                            "sSortDescending": ": attiva per ordinare la colonna in ordine decrescente"
                        }
                    },
                    "drawCallback": function (settings) {
                        // Init checkboxes with iCheck 
                        $("input[type='checkbox']", $(this))
                            .iCheck({
                                checkboxClass: 'icheckbox_minimal',
                                radioClass: 'iradio_minimal'
                            })
                            // Update database via Ajax on change
                            .on('ifChanged', function () {
                                $this = $(this);
                                var active = $this.is(':checked');
                                var langId = $this.attr('data-rowpk');
                                var action = $this.attr('data-action');
                                var param = {};
                                $('#table-lang').spin();

                                param.langId = langId;
                                param.active = $this.parents('tr').find('[data-action="activate"]').is(':checked');
                                param.autohide = $this.parents('tr').find('[data-action="autohide"]').is(':checked');

                                $.getJSON('Ajax/LangActivate.ashx', param)
                                    .fail(function (jqxhr, textStatus, error) {
                                        bootbox.alert('Si è verificaro un errore: ' + textStatus + ", " + error);
                                    })
                                    .done(function (data) {
                                        if (!data.success) {
                                            $.growl({
                                                icon: 'fa fa-warning',
                                                title: 'Si è verificato un errore ',
                                                message: data.msg
                                            },
                                            {
                                                type: 'danger'
                                            })
                                        }
                                    })
                                    .always(function () {

                                        $langtable.ajax.url('Ajax/LanguagesDT.ashx').load(function () {
                                            $('#table-lang').spin(false);
                                        });
                                    })
                            });
                    },
                    "columnDefs": [
                        {
                            "targets": 0,
                            "data": "LangId",
                            "width": "10%"
                        },
                        {
                            "targets": 1,
                            "data": "LangName",
                            "width": "70%"
                        },
                        {
                            "targets": 2,
                            "width": "10%",
                            "data": "Active",
                            "searchable": false,
                            "orderable": false,
                            "className": "text-center",
                            "render": function (data, type, full, meta) {
                                var $cb = $('<input />')
                                    //.addClass('btn btn-danger btn-xs')
                                    .attr('data-rowpk', full.LangId)
                                    .attr('data-action', 'activate')
                                    .attr('type', 'checkbox');
                                if (data)
                                    $cb.attr('checked', 'checked');
                                return $('<div />').append($cb).html();
                            }
                        },
                        {
                            "targets": 3,
                            "width": "10%",
                            "data": "AutoHide",
                            "searchable": false,
                            "orderable": false,
                            "className": "text-center",
                            "render": function (data, type, full, meta) {
                                var $cb = $('<input />')
                                    //.addClass('btn btn-danger btn-xs')
                                    .attr('data-rowpk', full.LangId)
                                    .attr('data-action', 'autohide')
                                    .attr('type', 'checkbox');
                                if (data)
                                    $cb.attr('checked', 'checked');
                                return $('<div />').append($cb).html();
                            }
                        }
                    ]
                });

            // Navigation config

            $('#fg-nav input, #fg-start input')
                .each(function (index) {
                    var $this = $(this);
                    $this.select2(
                    {
                        ajax: {
                            url: 'Ajax/Liste.ashx',
                            dataType: 'json',
                            quietMillis: 200,
                            data: function (term, page) {
                                return { k: term, idField: "CONTENUTI", idList: $this.attr('data-types') };
                            },
                            results: function (data, page, query) {
                                return { results: data };
                            }
                        },
                        initSelection: function (element, callback) {
                            var pk = $(element).val();
                            $.getJSON('Ajax/GetRecord.ashx', { pk: pk, table: 'MB_contenuti_title' }).done(function (data) {
                                if (pk != 0)
                                    callback({ id: pk, text: data.data });

                            });
                        },
                        allowClear: true
                    }).parent().tooltip({
                        container: 'body',
                        delay: { show: 500, hide: 300 },
                        title: $(this).attr('data-placeholder'),
                        trigger: 'hover'
                    }).on('click', function () {
                        $this.tooltip('hide');
                    });
                });

            // When pseudo-form is submitted
            $('#edit-config').on('submitted.mb.form', function (e, data) {
                //e.stopPropagation();
                if (data.success) {
                    $.growl({
                        icon: 'fa fa-thumbs-o-up',
                        title: 'Salvataggio dati',
                        message: data.msg
                    },
                    {
                        type: 'success'
                    });
                    // Post Id hidden fields updated !!
                    //$('[name="Pk"], [name="PostPk"]').val(data.pk);
                } else {
                    $.growl({
                        icon: 'fa fa-warning',
                        title: 'Si è verificato un errore: ',
                        message: data.msg
                    },
                    {
                        type: 'danger'
                    })
                }
            });

        });
    </script>
</asp:Content>
