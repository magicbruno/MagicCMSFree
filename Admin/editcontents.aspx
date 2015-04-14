﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterAdmin.master" AutoEventWireup="true"
    CodeBehind="editcontents.aspx.cs" Inherits="MagicCMS.Admin.editcontents" ValidateRequest="false"
    Culture="it-IT" UICulture="it" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeaderContent" runat="server">
    <h1><i class="fa fa-edit"></i>Modifica Container e Content</h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">

        <div class="col-xs-12">
            <asp:Panel runat="server" ID="Panel_contents" CssClass="box box-primary" data-id="Panel_contents">
                <div class="box-header">
                    <h3 class="box-title">Struttura del sito</h3>
                    <div class="box-tools pull-left">
                        <button data-action="add-element" type="button" class="btn btn-sm btn-success hidden">
                            <i class="fa fa-plus"></i>aggiungi
                        </button>
                    </div>
                    <div class="box-tools pull-right">
                        <button type="button" data-action="back" class="btn btn-sm btn-success btn-icon"
                            title="Back">
                            <i class="fa fa-arrow-left"></i>
                        </button>
                        <button type="button" data-action="home" class="btn btn-sm btn-success btn-icon"
                            title="Root">
                            <i class="fa fa-home"></i>
                        </button>
                        <button type="button" data-action="forward" class="btn btn-sm btn-success btn-icon"
                            title="Forward">
                            <i class="fa fa-arrow-right"></i>
                        </button>
                        <button type="button" data-action="full" class="btn btn-sm btn-success btn-icon"
                            title="Mostra tutti gli elementi">
                            <i class="fa fa-bars"></i>
                        </button>
                        <button type="button" data-action="inbasket" class="btn btn-sm btn-danger btn-icon"
                            title="Mostra gli elementi cncellati">
                            <i class="fa fa-trash-o"></i>
                        </button>
                        <button type="button" class="btn btn-primary btn-sm" data-widget="collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body">
                    <table id="table_contenuti" cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered"
                        cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th>Id</th>
                                <th>Titolo</th>
                                <th>Tipo di risorsa</th>
                                <th>Pubb.</th>
                                <th>Scad</th>
                                <th>Modif.</th>
                                <th>Ordine</th>
                                <th><i class="fa fa-edit"></i></th>
                                <th><i class="fa fa-plus-square-o"></i></th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </asp:Panel>
        </div>

        <div class="col-xs-12">
            <asp:Panel runat="server" ID="Panel_edit" CssClass="box box-warning">
                <div class="box-header">
                    <h3 class="box-title"><i class="fa <% = ThePost.TypeInfo.Icon %>"></i><% = PostEditTitle %>
                    </h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-primary btn-sm" data-widget="collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                    </div>
                </div>
                <div class="box-body">

                    <div class="nav-tabs-custom tabs-edit">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#main-data" data-toggle="tab"><i class="text-danger fa fa-flash hidden">
                            </i>Dati</a></li>
                            <li><a href="#parents-modal" data-toggle="modal">Parents</a></li>
                            <asp:Repeater ID="Repeter_Tabs" runat="server">
                                <ItemTemplate>
                                    <li>
                                        <a href="#lang-<%# DataBinder.Eval(Container, "DataItem.LangId") %>" data-toggle="tab">
                                            <i class="text-danger fa fa-flash hidden"></i><%# DataBinder.Eval(Container, "DataItem.LangName") %></a>
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>
                            <li class="pull-right"><a href="#help" data-toggle="tab" class="text-muted"><i class="fa fa-question-circle">
                            </i></a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <!-- Main data -->
                            <div class="tab-pane active" id="main-data">
                                <div class="form-horizontal" role="form" data-ride="mb-form" data-action="Ajax/Edit.ashx"
                                    id="edit-content">
                                    <fieldset>
                                        <input type="hidden" id="Pk" name="Pk" value="<% = Pk.ToString() %>" />
                                        <input type="hidden" id="Tipo" name="Tipo" value="<% = ThePost.Tipo.ToString() %>" />
                                        <input type="hidden" id="Parents" name="Parents" value="<% = PostParents %>" />
                                        <input type="hidden" id="table" name="table" value="MB_contenuti" />
                                        <div class="form-group" id="fg-titolo">
                                            <label for="Titolo" class="col-sm-2 control-label"><% = TypeInfo.LabelTitolo %></label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="Titolo" value="<% = ThePostEnc.Titolo %>" />
                                            </div>
                                        </div>
                                        <div class="form-group <% = FlagExtraInfo %>" id="fg-ExtraInfo">
                                            <label for="ExtraInfo" class="col-sm-2 control-label"><% = TypeInfo.LabelExtraInfo %></label>
                                            <div class="col-sm-10">
                                                <div class="<% = FlagBtnGeolog %>">
                                                    <input type="text" class="form-control" id="ExtraInfo" value="<% = ThePostEnc.ExtraInfo %>" />
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-icon btn-success btn-flat" type="button" data-source="#ExtraInfo"
                                                            title="Calcola geolocazione" data-target="#map-dialog" data-toggle="modal">
                                                            <i class="fa fa-map-marker"></i>
                                                        </button>
                                                    </span>
                                                </div>
                                                <!-- /input-group -->
                                            </div>
                                        </div>
                                        <div class="form-group <% = FlagExtrInfo1 %>" id="fg-extrainfo1">
                                            <label for="ExtraInfo1" class="col-sm-2 control-label"><% = TypeInfo.LabelExtraInfo1 %></label>
                                            <div class="col-sm-10">
                                                <textarea class="form-control" id="ExtraInfo1" rows="2"><% = ThePost.ExtraInfo1 %></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group <% = FlagExtrInfo2 %>" id="fg-ExtraInfo2">
                                            <label for="ExtraInfo2" class="col-sm-2 control-label"><% = TypeInfo.LabelExtraInfo2 %></label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="ExtraInfo2" value="<% = ThePostEnc.ExtraInfo2 %>" />
                                            </div>
                                        </div>
                                        <div class="form-group <% = FlagExtrInfo3 %>" id="fg-ExtraInfo3">
                                            <label for="ExtraInfo3" class="col-sm-2 control-label"><% = TypeInfo.LabelExtraInfo3 %></label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="ExtraInfo3" value="<% = ThePostEnc.ExtraInfo3 %>" />
                                            </div>
                                        </div>
                                        <div class="form-group <% = FlagExtrInfo4 %>" id="fg-ExtraInfo4">
                                            <label for="ExtraInfo4" class="col-sm-2 control-label"><% = TypeInfo.LabelExtraInfo4 %></label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="ExtraInfo4" value="<% = ThePostEnc.ExtraInfo4 %>" />
                                            </div>
                                        </div>
                                        <div class="form-group <% = FlagUrl %>" id="Div1">
                                            <label for="Url" class="col-sm-2 control-label"><% = TypeInfo.LabelUrl %></label>
                                            <div class="col-sm-10">
                                                <div class="input-group">
                                                    <input type="text" class="form-control" id="Url" value="<% = ThePostEnc.Url %>" />
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-primary btn-flat <% = FlagCercaServer %>" type="button" data-callback="getUrl"
                                                            title="Sfoglia il server"
                                                            data-target="#FileBrowserModal" data-toggle="modal">
                                                            <i class="fa fa-search"></i>Sfoglia...</button>
                                                        <button class="btn btn-info btn-flat btn-icon" type="button" data-source="#Url" title="Guarda il file"
                                                            data-target="#LightBox" data-toggle="modal">
                                                            <i class="fa fa-search-plus"></i>
                                                        </button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group <% = FlagUrlSecondaria %>" id="Div2">
                                            <label for="Url2" class="col-sm-2 control-label"><% = TypeInfo.LabelUrlSecondaria %></label>
                                            <div class="col-sm-10">
                                                <div class="input-group">
                                                    <input type="text" class="form-control" id="Url2" value="<% = ThePostEnc.Url2  %>" />
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-primary btn-flat <% = FlagCercaServer %>" type="button" data-callback="getUrl2"
                                                            title="Sfoglia il server"
                                                            data-target="#FileBrowserModal" data-toggle="modal">
                                                            <i class="fa fa-search"></i>Sfoglia...</button>
                                                        <button class="btn btn-info btn-flat btn-icon" type="button" data-source="#Url2"
                                                            title="Guarda il file"
                                                            data-target="#LightBox" data-toggle="modal">
                                                            <i class="fa fa-search-plus"></i>
                                                        </button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group" id="fg-data-dimensioni">
                                            <label for="Ordinamento" class="col-sm-2 control-label">Rilevanza</label>
                                            <div class="col-lg-2 col-sm-4">
                                                <input type="text" class="form-control" id="Ordinamento" value="<% = ThePost.Ordinamento.ToString() %>" />
                                            </div>
                                            <label for="Larghezza" class="col-sm-2 control-label <% = FlagLarghezza %>">
                                                <% = TypeInfo.LabelLarghezza %></label>
                                            <div class="col-lg-2 col-sm-4  <% = FlagLarghezza %>">
                                                <input type="text" class="form-control" id="Text1" value="<% = ThePost.Larghezza.ToString() %>" />
                                            </div>
                                            <label for="Larghezza" class="col-sm-2 control-label <% = FlagAltezza %>"><% = TypeInfo.LabelAltezza %></label>
                                            <div class="col-lg-2 col-sm-4  <% = FlagAltezza %>">
                                                <input type="text" class="form-control" id="Larghezza" value="<% = ThePost.Altezza.ToString() %>" />
                                            </div>
                                            <label for="DataPubblicazione" class="col-sm-2 control-label">Data pubblicazione</label>
                                            <div class="col-lg-2 col-sm-4 ">
                                                <div class="input-group date">
                                                    <input type="text" data-dateiso="<% = DataPubblicazioneStr %>" class="form-control datepicker" id="DataPubblicazione" value="" />
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-flat btn-primary btn-icon" type="button">
                                                            <i class="fa fa-calendar"></i>
                                                        </button>
                                                    </span>
                                                </div>
                                            </div>
                                            <label for="DataScadenza" class="col-sm-2 control-label <% = FlagScadenza %>"><% = TypeInfo.LabelScadenza %></label>
                                            <div class="col-lg-2 col-sm-4 <% = FlagScadenza %>">
                                                <div class="input-group date">
                                                    <input type="text" data-dateiso="<% = DataScadenzaStr %>" class="form-control datepicker" id="DataScadenza" value="" />
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-flat btn-primary btn-icon" type="button">
                                                            <i class="fa fa-calendar"></i>
                                                        </button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class='box box-success <% = FlagBreve %>'>
                                            <div class='box-header'>
                                                <h3 class='box-title'><% = TypeInfo.LabelTestoBreve %></h3>
                                                <!-- tools box -->
                                                <div class="pull-right box-tools">
                                                    <button class="btn btn-success btn-sm" data-widget='collapse' data-toggle="tooltip"
                                                        title="Comprimi" type="button">
                                                        <i class="fa fa-minus"></i>
                                                    </button>
                                                </div>
                                                <!-- /. tools -->
                                            </div>
                                            <!-- /.box-header -->
                                            <div class='box-body pad'>
                                                <textarea id="TestoBreve" name="TestoBreve" rows="10" class="ckeditor_mcms <% = FlagBreve %>"><% = ThePostEnc.TestoBreve %></textarea>
                                            </div>
                                        </div>
                                        <div class='box box-info <% = FlagFull %>'>
                                            <div class='box-header'>
                                                <h3 class='box-title'><% = TypeInfo.LabelTestoLungo %></h3>
                                                <!-- tools box -->
                                                <div class="pull-right box-tools">
                                                    <button class="btn btn-info btn-sm" data-widget='collapse' data-toggle="tooltip"
                                                        title="Comprimi" type="button">
                                                        <i class="fa fa-minus"></i>
                                                    </button>
                                                </div>
                                                <!-- /. tools -->
                                            </div>
                                            <!-- /.box-header -->
                                            <div class='box-body pad'>
                                                <textarea id="TestoLungo" name="TestoLungo" rows="10" class="ckeditor_mcms <% = FlagFull %>"><% = ThePostEnc.TestoLungo %></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group <% = FlagTags %>" id="fg-tags">
                                            <label for="ProcessParoleChiaveo_PK" class="col-sm-2 control-label">Tags</label>
                                            <div class="col-sm-10">
                                                <input type="hidden" class="form-control" id="Tags" value="<% = ThePostEnc.Tags %>" />
                                            </div>
                                        </div>
                                        <div class="form-group <% = FlagExtraInfo_5 %>" id="fg-ExtraInfo5">
                                            <label for="ExtraInfo5" class="col-sm-2 control-label"><% = TypeInfo.LabelExtraInfo_5 %></label>
                                            <div class="col-sm-10">
                                                <textarea class="form-control" id="ExtraInfo5" rows="2"><% = ThePostEnc.ExtraInfo5 %></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group <% = FlagExtraInfo_6 %>" id="fg-ExtraInfo6">
                                            <label for="ExtraInfo6" class="col-sm-2 control-label"><% = TypeInfo.LabelExtraInfo_6 %></label>
                                            <div class="col-sm-10">
                                                <textarea class="form-control" id="ExtraInfo6" rows="2"><% = ThePostEnc.ExtraInfo6 %></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group <% = FlagExtraInfo_7 %>" id="fg-ExtraInfo7">
                                            <label for="ExtraInfo7" class="col-sm-2 control-label"><% = TypeInfo.LabelExtraInfo_7 %></label>
                                            <div class="col-sm-10">
                                                <textarea class="form-control" id="ExtraInfo7" rows="2"><% = ThePostEnc.ExtraInfo7 %></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group <% = FlagExtraInfo_8 %>" id="fg-ExtraInfo8">
                                            <label for="ExtraInfo8" class="col-sm-2 control-label"><% = TypeInfo.LabelExtraInfo_8 %></label>
                                            <div class="col-sm-10">
                                                <textarea class="form-control" id="ExtraInfo8" rows="2"><% = ThePostEnc.ExtraInfo8 %></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group <% = FlagExtraInfoNumberAll %>" id="fg-floats">
                                            <label for="ExtraInfoNumber1" class="col-sm-2 control-label <% = FlagExtraInfoNumber_1 %>">
                                                <% = TypeInfo.LabelExtraInfoNumber_1 %></label>
                                            <div class="col-lg-2 col-sm-4 <% = FlagExtraInfoNumber_1 %>">
                                                <input type="text" class="form-control float" id="ExtraInfoNumber1" value="<% = ThePost.ExtraInfoNumber1.ToString() %>" />
                                            </div>
                                            <label for="ExtraInfoNumber2" class="col-sm-2 control-label <% = FlagExtraInfoNumber_2 %>">
                                                <% = TypeInfo.LabelExtraInfoNumber_2 %></label>
                                            <div class="col-lg-2 col-sm-4">
                                                <input type="text" class="form-control float <% = FlagExtraInfoNumber_2 %>" id="ExtraInfoNumber2"
                                                    value="<% = ThePost.ExtraInfoNumber2.ToString() %>" />
                                            </div>
                                            <label for="ExtraInfoNumber3" class="col-sm-2 control-label <% = FlagExtraInfoNumber_3 %>">
                                                <% = TypeInfo.LabelExtraInfoNumber_3 %></label>
                                            <div class="col-lg-2 col-sm-4 <% = FlagExtraInfoNumber_3 %>">
                                                <input type="text" class="form-control float " id="ExtraInfoNumber3" value="<% = ThePost.ExtraInfoNumber3.ToString() %>" />
                                            </div>
                                            <label for="ExtraInfoNumber4" class="col-sm-2 control-label <% = FlagExtraInfoNumber_4 %>">
                                                <% = TypeInfo.LabelExtraInfoNumber_4 %></label>
                                            <div class="col-lg-2 col-sm-4 <% = FlagExtraInfoNumber_4 %>">
                                                <input type="text" class="form-control float" id="ExtraInfoNumber4" value="<% = ThePost.ExtraInfoNumber4.ToString() %>" />
                                            </div>
                                            <label for="ExtraInfoNumber5" class="col-sm-2 control-label <% = FlagExtraInfoNumber_5 %>">
                                                <% = TypeInfo.LabelExtraInfoNumber_5 %></label>
                                            <div class="col-lg-2 col-sm-4 <% = FlagExtraInfoNumber_5 %>">
                                                <input type="text" class="form-control float" id="ExtraInfoNumber5" value="<% = ThePost.ExtraInfoNumber5.ToString() %>" />
                                            </div>
                                            <label for="ExtraInfoNumber6" class="col-sm-2 control-label <% = FlagExtraInfoNumber_6 %>">
                                                <% = TypeInfo.LabelExtraInfoNumber_6 %></label>
                                            <div class="col-lg-2 col-sm-4 <% = FlagExtraInfoNumber_6 %>">
                                                <input type="text" class="form-control float" id="ExtraInfoNumber6" value="<% = ThePost.ExtraInfoNumber6.ToString() %>" />
                                            </div>
                                            <label for="ExtraInfoNumber7" class="col-sm-2 control-label <% = FlagExtraInfoNumber_7 %>">
                                                <% = TypeInfo.LabelExtraInfoNumber_7 %></label>
                                            <div class="col-lg-2 col-sm-4 <% = FlagExtraInfoNumber_7 %>">
                                                <input type="text" class="form-control float" id="ExtraInfoNumber7" value="<% = ThePost.ExtraInfoNumber7.ToString() %>" />
                                            </div>
                                            <label for="ExtraInfoNumber8" class="col-sm-2 control-label <% = FlagExtraInfoNumber_8 %>">
                                                <% = TypeInfo.LabelExtraInfoNumber_8 %></label>
                                            <div class="col-lg-2 col-sm-4 <% = FlagExtraInfoNumber_8 %>">
                                                <input type="text" class="form-control float" id="ExtraInfoNumber8" value="<% = ThePost.ExtraInfoNumber8.ToString() %>" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-12 text-center">
                                                <button type="button" class="btn btn-primary" data-action="submit">
                                                    Salva modifiche</button>
                                                <button type="button" class="btn btn-info" data-action="duplicate">Crea duplicato</button>
                                                <button data-target="#preview-modal" data-toggle="modal" type="button" class="btn btn-info" data-action="show-record">Mostra la pagina</button>
                                                <button data-target="#preview-modal"  data-toggle="modal" type="button" class="btn btn-info" data-action="show-in-parent">Mostra nel contenitore</button>
                                            </div>
                                        </div>
                                        <%--<div class="alert"></div>--%>
                                    </fieldset>
                                </div>
                            </div>
                            <!-- /main-data -->
                            <!-- Parents -->
                            <div class="tab-pane" id="parents">
                                <div class="parents-tree" id="parents-tree">
                                </div>
                            </div>
                            <!-- /Parents -->

                            <asp:Repeater ID="RepeaterLanguages" runat="server">
                                <ItemTemplate>
                                    <div class="tab-pane" id="lang-<%# DataBinder.Eval(Container, "DataItem.LangId") %>">
                                        <div class="form-horizontal" role="form" data-ride="mb-form" data-action="Ajax/Edit.ashx"
                                            id="edit-lang-<%# DataBinder.Eval(Container, "DataItem.LangId") %>">
                                            <fieldset>
                                                <input type="hidden" name="LangId" value="<%# DataBinder.Eval(Container, "DataItem.LangId") %>" />
                                                <input type="hidden" name="table" value="ANA_TRANSLATION" />
                                                <input type="hidden" name="PostPk" value="<% = Pk.ToString() %>" />
                                                <div class="form-group">
                                                    <label for="Titolo-<%# DataBinder.Eval(Container, "DataItem.LangId") %>" class="col-sm-2 control-label">
                                                        Titolo</label>
                                                    <div class="col-sm-10">
                                                        <textarea rows="2" class="form-control" id="Titolo<%# DataBinder.Eval(Container, "DataItem.LangId") %>"
                                                            name="TranslatedTitle"><%# DataBinder.Eval(Container, "DataItem.TranslatedTitle") %></textarea>
                                                    </div>
                                                </div>
                                                <div class="form-group <% = FlagBreve %>">
                                                    <label for="TestoBreve-<%# DataBinder.Eval(Container, "DataItem.LangId") %>" class="col-sm-2 control-label">
                                                        Testo breve</label>
                                                    <div class="col-xs-10">
                                                        <textarea name="TranslatedTestoBreve" rows="10" class="ckeditor_mcms <% = FlagBreve %>"><%# System.Web.HttpUtility.HtmlEncode(DataBinder.Eval(Container, "DataItem.TranslatedTestoBreve").ToString()) %></textarea>
                                                    </div>
                                                </div>
                                                <div class="form-group <% = FlagFull %>">
                                                    <label for="TestoLungo-<%# DataBinder.Eval(Container, "DataItem.LangId") %>" class="col-sm-2 control-label">
                                                        Testo lungo</label>
                                                    <div class="col-xs-10">
                                                        <textarea name="TranslatedTestoLungo" rows="10" class="ckeditor_mcms <% = FlagFull %>"><%# System.Web.HttpUtility.HtmlEncode(DataBinder.Eval(Container, "DataItem.TranslatedTestoLungo").ToString()) %></textarea>
                                                    </div>
                                                </div>
                                                <div class="form-group <% = FlagTags %>" id="fg-tags">
                                                    <label for="" class="col-sm-2 control-label">Tags</label>
                                                    <div class="col-sm-10">
                                                        <input type="hidden" class="form-control" name="TranslatedTags" value="<%# DataBinder.Eval(Container, "DataItem.TranslatedTags")%>" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-sm-12 text-center">
                                                        <button type="button" class="btn btn-primary btn-sm" data-action="submit">
                                                            Salva traduzione</button>
                                                        <button type="button" <%# !CmsConfig.TransAuto ? "disabled" : ""  %> class="btn btn-info btn-sm"
                                                            data-action="translate">
                                                            Traduci con Bing</button>
                                                        <button type="button" class="btn btn-danger btn-sm" data-action="delete-translation">
                                                            Elimina traduzione</button>
                                                    </div>
                                                </div>
                                            </fieldset>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <div class="tab-pane" id="help">
                                <% = TypeInfo.Help %>
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>
        </div>
    </div>
    <!-- Parents Modal  -->
    <div class="modal fade" id="parents-modal" tabindex="-1" role="dialog" aria-labelledby="Types"
        aria-hidden="true" data-backdrop="static" data-source="">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span><span
                            class="sr-only">Close</span></button>
                    <h4 class="modal-title">Parents dell'oggetto</h4>
                </div>
                <div class="modal-body">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal">
                    Chiudi</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Preview Modal  -->
    <div class="modal fade" id="preview-modal" tabindex="-1" role="dialog" aria-labelledby="Types"
        aria-hidden="true" data-backdrop="static" data-source="">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span><span
                            class="sr-only">Close</span></button>
                    <h4 class="modal-title"></h4>
                </div>
                <div class="modal-body">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal">
                    Chiudi</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Scripts" runat="server">
    <script>
        /// <reference path="../../../Scripts/_references.js" />

        // Handle checking if some change was made

        // Global variables

        var tableContentHistory;
        $form_contents = $('#edit-content');
        /** 
        ------------- TableStatus -------------
        Define table status (filter an order) memorized in TableHistory
        **/
        var TableStatus = function (parentId, order, name) {
            this.parent = parentId;
            this.setOrder(order);
            this.page = 0;
            this.setName(name);
        }
        TableStatus.prototype = {
            parent: 0,
            order: [6, 'asc'],
            page: 0,
            name: 'Root',
            search: '',
            setName: function (name) {
                if (this.parent == 0)
                    this.name = "Root";
                else
                    this.name = name;
            },
            setOrder: function (order) {
                if (order.constructor === Array)
                    this.order = order;
                else {
                    switch (order.toUpperCase().trim()) {
                        case "ALPHA ASC":
                        case "ALPHA":
                            order = [1, 'asc'];
                            break;

                        case "ALPHA DESC":
                            order = [1, 'desc'];
                            break;

                        case "DESC":
                            order = [6, 'desc'];
                            break;

                        case "ASC":
                            order = [6, 'asc'];
                            break;

                        case "DATA DESC":
                        case "DESC DATA":
                            order = [3, 'desc'];
                            break;

                        case "DATA ASC":
                        case "ASC DATA":
                            order = [3, 'asc'];
                            break;

                        case "DATAMODIFICA DESC":
                        case "DESC DATAMODIFICA":
                            order = [5, 'asc'];
                            break;

                        case "DATAMODIFICA ASC":
                        case "ASC DATAMODIFICA":
                            order = [5, 'desc'];
                            break;

                        default:
                            order = [6, 'asc'];
                            break;
                    }

                }
            }
        };


        var $parentstree;


        /**
        ************** Hndlers for Filebrowser ********************
        **/
        function getUrl(url) {
            $('#Url').val(url).change();
            $('#FileBrowserModal').modal('hide');
        }

        function getUrl2(url) {
            $('#Url2').val(url).change();
            $('#FileBrowserModal').modal('hide');
        }



        $(function () {

            /*
            Parents modal
            */
            $('#parents-modal').on('show.bs.modal', function () {
                var $modalbody =  $(this).find('.modal-body');
                var $modalContent = $('#parents');
                if (!$modalbody.children().length)
                    $modalbody.append($modalContent);

            })



            /*
            ** Contents navigation table
            **/

            // datatable
            var $table_contenuti =
             $('#table_contenuti')
                 .on('xhr.dt', function (e, settings, json) {
                     var xhr = settings.jqXHR;
                     if (xhr.status == 403) {
                         bootbox.alert('Sessione scaduta. È necessario ripetere il login.', function () {
                             window.location.href = "login.aspx";
                         });
                     }
                 })
                 .DataTable({
                     "serverSide": true,
                     "ajax": {
                         "url": "Ajax/ContentsPaginated.ashx",
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
                     "columnDefs": [
                         {
                             "targets": 0,
                             "data": "Pk",
                             "searchable": false,
                             "name": "Id",
                             "className": "text-right"
                         },
                         {
                             "targets": 1,
                             "data": "Titolo",
                             "name": "Titolo",
                             "width": "20%",
                             render: function (data, type, full, meta) {
                                 if (full.FlagContainer) {
                                     var btn = $('<button />')
                                                 .addClass('btn btn-link ellipses')
                                                 .attr('data-rowpk', full.Pk)
                                                 .attr('data-rowtitle', full.Titolo)
                                                 .attr('data-action', 'goto')
                                                 .attr('data-order', full.ExtraInfo)
                                                 .attr('data-icon', full.Icon)
                                                 .attr('type', 'button')
                                                 .attr('title', data + " (" + full.NomeTipo + ")")
                                                 .html('<i class="fa ' + full.Icon + '"></i>' + data);
                                     if (full.FlagCancellazione)
                                         btn.attr('disabled', 'disabled');
                                     var div = $('<div class="ellipsis title" />').append(btn);
                                     return $('<div />').append(div).html();
                                 }
                                 else
                                     return '<div class="ellipsis title"><span><i class="fa ' + full.Icon + '"></i>' + data + '</span></div>';
                             }
                         },
                         {
                             "targets": 2,
                             "name": "TYP_NAME",
                             "searchable": true,
                             "orderable": true,
                             "data": "NomeTipo",
                             "width": "10%",
                             "render": function (data, type, full, meta) {
                                 var miniature = full.Miniature_pk;
                                 if (miniature == 0)
                                     return '<div class="ellipsis type">' + data + '</div>';
                                 else {
                                     var btn = $('<button />')
                                                 .addClass('btn btn-link')
                                                 .attr('data-action', 'show')
                                                 .attr('data-url', full.Url)
                                                 .attr('type', 'button')
                                                 .attr('data-target', '#LightBox')
                                                 .attr('data-toggle', 'modal')
                                                 .attr('title', data)
                                                 .html('<img class="img-responsive" src="/Min.ashx?pk=' + miniature + '"></img>');

                                     var div = $('<div />').append(btn);
                                     return $('<div />').append(div).html();
                                 }
                             }
                         },
                         {
                             "targets": 3,
                             "searchable": false,
                             "orderable": true,
                             "data": "DataPubblicazione",
                             "name": "DataPubblicazione",
                             "width": "10%",
                             "className": "text-right",
                             "render": function (data, type, full, meta) {
                                 if (data == null) return "Mancante";
                                 var d = new Date(parseInt(data.substr(6)));
                                 return d.getDate() + '/' + ('0' + (d.getMonth() + 1)).substr(-2) + "/" + d.getFullYear().toString().substr(-2);
                             }
                         },
                         {
                             "targets": 4,
                             "searchable": false,
                             "orderable": true,
                             "data": "DataScadenza",
                             "name": "DataScadenza",
                             "width": "10%",
                             "className": "text-right",
                             "render": function (data, type, full, meta) {
                                 if (data == null) return "Nessuna";
                                 var d = new Date(parseInt(data.substr(6)));
                                 return d.getDate() + '/' + ('0' + (d.getMonth() + 1)).substr(-2) + "/" + d.getFullYear().toString().substr(-2);
                             }
                         },
                         {
                             "targets": 5,
                             "searchable": false,
                             "orderable": true,
                             "data": "DataUltimaModifica",
                             "name": "DataUltimaModifica",
                             "width": "10%",
                             "className": "text-right",
                             "render": function (data, type, full, meta) {
                                 if (data == null) return "Mancante";
                                 var d = new Date(parseInt(data.substr(6)));
                                 return d.getDate() + '/' + ('0' + (d.getMonth() + 1)).substr(-2) + "/" + d.getFullYear().toString().substr(-2);
                             }
                         },
                         {
                             "targets": 6,
                             "name": "Ordinamento",
                             "searchable": false,
                             "orderable": true,
                             "visible": false,
                             "data": "Order"
                         },
                         {
                             "targets": 7,
                             "data": "Pk",
                             "searchable": false,
                             "orderable": false,
                             "className": "text-center",
                             "render": function (data, type, full, meta) {
                                 var btn;
                                 if (full.FlagCancellazione) {
                                     btn = $('<button />')
                                         .addClass('btn btn-success btn-xs')
                                         .attr('data-rowpk', full.Pk)
                                         .attr('data-action', 'undelete')
                                         .attr('type', 'button')
                                         .html('<i class="fa fa-external-link-square"></i>recupera');
                                 } else {
                                     btn = $('<a />')
                                         .addClass('btn btn-primary btn-xs')
                                         .attr('data-rowpk', full.Pk)
                                         .attr('data-action', 'edit')
                                         .attr('href', 'editcontents.aspx?pk=' + full.Pk)
                                         .html('<i class="fa fa-edit"></i>modifica');
                                 }


                                 return $('<div />').append(btn).html();
                             }
                         },
                         {
                             "targets": 8,
                             "data": "Pk",
                             "searchable": false,
                             "orderable": false,
                             "className": "text-center",
                             "render": function (data, type, full, meta) {
                                 var btn;
                                 if (full.FlagCancellazione) {
                                     btn = $('<button />')
                                         .addClass('btn btn-danger btn-xs')
                                         .attr('data-rowpk', full.Pk)
                                         .attr('data-action', 'erase')
                                         .attr('type', 'button')
                                         .html('<i class="fa fa-eraser"></i>elimina');
                                 } else {
                                     btn = $('<button />')
                                         .addClass('btn btn-danger btn-xs')
                                         .attr('data-rowpk', full.Pk)
                                         .attr('data-action', 'delete')
                                         .attr('type', 'button')
                                         .html('<i class="fa fa-trash"></i>cestino');
                                 }
                                 return $('<div />').append(btn).html();
                             }
                         }
                     ]
                 });



            //DataTable events
            $table_contenuti
                .on('draw.dt column-sizing.dt ', function () {
                    var w = $(this).parents('.box-body').width();
                    $('td > div.ellipsis.title').width(w * 0.25);
                    $('td > div.ellipsis.type').width(w * 0.18);
                })
                .on('click', 'button', function (e) {
                    var $button = $(this);
                    var action = $button.attr('data-action');
                    var pk = $button.attr('data-rowpk');
                    var order = $button.attr('data-order');
                    var name = $button.attr('data-rowtitle');
                    switch (action) {
                        case 'undelete':
                            $('[data-id="Panel_contents"]').spin();
                            $.ajax({
                                type: "POST",
                                url: "Ajax/Delete.ashx",
                                data: {
                                    table: "MB_Contenuti",
                                    pk: $button.attr('data-rowpk'),
                                    undelete: 1
                                },
                                dataType: "json"
                            })
                            .done(function (data) {
                                if (data.success) {
                                    $table_contenuti.ajax.reload();
                                    $.growl({
                                        icon: 'fa fa-thumbs-o-up',
                                        title: '',
                                        message: data.msg
                                    },
                                    {
                                        type: 'success'
                                    });
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
                            })
                            .fail(function (jqxhr, textStatus, error) {
                                bootbox.alert('Si è verificaro un errore: ' + textStatus + "," + error);
                            })
                            .always(function () {
                                $('[data-id="Panel_contents"]').spin(false);
                            }); break;
                            break;
                        case 'delete':
                        case 'erase':
                            var msg;
                            if (action == "erase")
                                msg = 'L\'elemento verrà eliminato definitivamente. Sei sicuro di voler continuare?';
                            else
                                msg = 'Stai spostando l\'elemento nel cestino. Ser sicuro di voler continuare?';

                            bootbox.confirm(msg, function (result) {
                                if (result) {
                                    $('[data-id="Panel_contents"]').spin();
                                    $.ajax({
                                        type: "POST",
                                        url: "Ajax/Delete.ashx",
                                        data: {
                                            table: "MB_Contenuti",
                                            pk: $button.attr('data-rowpk'),
                                            undelete: 0
                                        },
                                        dataType: "json"
                                    })
                                    .done(function (data) {
                                        if (data.success) {
                                            $table_contenuti.ajax.reload();
                                            $.growl({
                                                icon: 'fa fa-thumbs-o-up',
                                                title: '',
                                                message: data.msg
                                            },
                                            {
                                                type: 'success'
                                            });

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
                                    })
                                    .fail(function (jqxhr, textStatus, error) {
                                        $.growl({
                                            icon: 'fa fa-warning',
                                            message: textStatus
                                        },
                                        {
                                            type: 'danger'
                                        })
                                    })
                                    .always(function () {
                                        $('[data-id="Panel_contents"]').spin(false);
                                    });
                                }
                            });

                            break;
                        case 'add':
                            break;
                        case 'show':
                            e.stopPropagation();
                            $('#LightBox').modal('show', $button);
                            break;
                        case 'goto':
                            var obj = new TableStatus(pk, order, name);
                            obj.icon = $button.attr('data-icon');
                            obj.search = '';
                            tableContentHistory.getCurrent().search = $table_contenuti.search();
                            tableContentHistory.goto(obj);
                            break;
                        default:
                            break;
                    }
                })
            // Update of History info on page changing
            .on('page.dt', function (e, settings) {
                var info = $table_contenuti.page.info();
                var obj = tableContentHistory.getCurrent();
                obj.page = info.page;
                //obj.search = $table_contenuti.search();
                tableContentHistory.setCurrent(obj);
            });

            /*
            ** /Contents navigation table end
            **/

            // Loading tags from database
            $('#Tags').parent().spin();
            $.getJSON('Ajax/Keys.ashx', { lang: "default" })
                .fail(function (jqxhr, textStatus, error) {
                    $alert
                        .text('Si è verificaro un errore: ' + textStatus + "," + error)
                        .removeClass('alert-success')
                        .addClass('alert-danger')
                        .show();
                })
                .done(function (data) {
                    if (data) {
                        $('#Tags')
                            .select2(
                                {
                                    tags: data.data,
                                    initSelection: function (element, callback) {
                                        var keys = element.val().split(',');
                                        var s2Arr = [];
                                        for (var i = 0; i < keys.length; i++) {
                                            if (keys[i].trim())
                                                s2Arr.push({ id: keys[i], text: keys[i] });
                                        }
                                        callback(s2Arr);
                                    },
                                    placeholder: 'Parole chiave',
                                    multiple: true
                                });
                    } else {
                        $.growl({
                            icon: 'fa fa-warning',
                            title: 'Si è verificato un errore: ',
                            message: data.msg
                        },
                        {
                            type: 'danger'
                        });
                    }
                })
                .always(function () {
                    $('#Tags').parent().spin(false);
                })

            // Loading translated tags from database
            $('[name="TranslatedTags"]').each(function () {
                var $tags = $(this);
                var lang = $tags.parents('.form-horizontal').find('[name="LangId"]').val();
                $tags.parent().spin();
                $.getJSON('Ajax/Keys.ashx', { lang: lang })
                    .fail(function (jqxhr, textStatus, error) {
                        $alert
                            .text('Si è verificaro un errore: ' + textStatus + "," + error)
                            .removeClass('alert-success')
                            .addClass('alert-danger')
                            .show();
                    })
                    .done(function (data) {
                        if (data) {
                            $tags
                                .select2(
                                    {
                                        tags: data.data,
                                        initSelection: function (element, callback) {
                                            var keys = element.val().split(',');
                                            var s2Arr = [];
                                            for (var i = 0; i < keys.length; i++) {
                                                if (keys[i].trim())
                                                    s2Arr.push({ id: keys[i], text: keys[i] });
                                            }
                                            callback(s2Arr);
                                        },
                                        placeholder: 'Parole chiave',
                                        multiple: true
                                    });
                        } else {
                            $.growl({
                                icon: 'fa fa-warning',
                                title: 'Si è verificato un errore: ',
                                message: data.msg
                            },
                            {
                                type: 'danger'
                            });
                        }
                    })
                    .always(function () {
                        $tags.parent().spin(false);
                    })
            })


            /*
            ** Handling contents table navigation history 
            **/
            //localStorage.removeItem('tableContentHistory');
            tableContentHistory = new Mb_history({
                home: new TableStatus(0, [6, 'asc'], 'Root'),
                action: function (obj, index, len) {
                    var $panel = $('[data-id="Panel_contents"]');
                    $panel.spin();
                    if ($table_contenuti.ajax) {
                        $table_contenuti.ajax.url('Ajax/ContentsPaginated.ashx?parent_id=' + obj.parent).load(function () {
                            var $boxTitle = $('[data-id="Panel_contents"]').find('.box-title');
                            var $addElementBtn = $('[data-action="add-element"]');
                            switch (obj.parent) {
                                case 0:
                                    $boxTitle.html('<i class="fa fa-home"></i>' + obj.name);
                                    $addElementBtn.addClass('hidden');
                                    break;
                                case -1:
                                    $boxTitle.html('<i class="fa fa-bars"></i>' + obj.name);
                                    $addElementBtn.addClass('hidden');
                                    break;
                                case -2:
                                    $boxTitle.html('<i class="fa fa-trash-o"></i>' + obj.name);
                                    $addElementBtn.addClass('hidden');
                                    break;
                                default:
                                    $boxTitle.html('<i class="fa ' + obj.icon + '"></i>' + obj.name);
                                    $addElementBtn
                                        .attr('data-title', 'Aggiungi un elemento a &quot;' + obj.name + '&quot;')
                                        .attr('data-parent', obj.parent)
                                        .removeClass('hidden');
                                    break;
                            }

                            setTimeout(function () {
                                $table_contenuti
                                    .order(obj.order);
                                $table_contenuti
                                    .search(obj.search);
                                $table_contenuti
                                    .page(obj.page)
                                    .draw(false);
                                $panel.spin(false);
                            }, 10)

                            var $back = $('[data-action="back"]');
                            var $forward = $('[data-action="forward"]');
                            var $home = $('[data-action="home"]');
                            if (index > 0)
                                $back.removeAttr('disabled');
                            else
                                $back.attr('disabled', 'disabled');

                            if (len > (index + 1))
                                $forward.removeAttr('disabled');
                            else
                                $forward.attr('disabled', 'disabled');
                            if (typeof window.JSON !== "undefined") {
                                var homeState = JSON.stringify(tableContentHistory.home);
                                var currentState = JSON.stringify(tableContentHistory.history[tableContentHistory.current]);
                                if (homeState === currentState)
                                    $home.attr('disabled', 'disabled')
                                else
                                    $home.removeAttr('disabled');
                            }

                        })
                    }
                }
            });

            // Carico l'history memorizzata in local storage
            tableContentHistory.load('tableContentHistory');

            /*
            ** /navigation history end
            **/

            // Add child element button
            $('[data-action="add-element"]')
                .tooltip({
                    trigger: 'hover',
                    container: 'body',
                    html: true,
                    title: function () {
                        return $(this).attr('data-title');
                    }
                })
                .on('mousedown', function () {
                    $(this).tooltip('hide');
                })
                .popover({
                    trigger: 'focus',
                    container: 'body',
                    placement: 'bottom',
                    html: true,
                    title: function () {
                        return $(this).attr('data-title');
                    },
                    content: function () {
                        var $this = $(this);
                        var uniqueid = 'pop-' + $.now();
                        (function () {
                            setTimeout(function () {
                                $('#' + uniqueid)
                                    .spin()
                                    .load('Ajax/GetContainerrPreferred.ashx', 'parent=' + $this.attr('data-parent'), function () {
                                        $('#' + uniqueid).spin(false);
                                    })
                            }, 100);
                        })();
                        return '<div id="' + uniqueid + '">Caricamento in corso...</div>';
                    }
                });

            // Handlers for other buttons
            $('[data-action]').on('click', function () {
                var $this = $(this);
                var action = $this.attr('data-action');
                // Accuirni la ricerca custom del record corrente
                tableContentHistory.getCurrent().search = $table_contenuti.search();
                switch (action) {
                    case 'url':
                        tableContentHistory.forward();
                        break;
                    case 'url2':
                        tableContentHistory.forward();
                        break;
                    case 'forward':
                        tableContentHistory.forward();
                        break;
                    case 'back':
                        tableContentHistory.back();
                        break;
                    case "home":
                        tableContentHistory.gohome();
                        break;
                    case "full":
                        tableContentHistory.goto(new TableStatus(-1, "ALPHA ASC", 'Tutti'));
                        break;
                    case "inbasket":
                        tableContentHistory.goto(new TableStatus(-2, "ALPHA ASC", 'Cestino'));
                        break;
                    case "duplicate":
                        var dup = function() {
                            $('#Pk').val(0);
                            var $titolo = $('#Titolo');
                            $titolo.val($titolo.val() + '(duplicato)');
                            $('[name="PostPk"]').val(0);
                        };
                        if ($('#Parents').parents('[role="form"]').mb_submit('pendingChanges')) {
                            bootbox.confirm('Ci sono modifiche non salvate! Vuoi contunuare?', function (result) {
                                if (result) dup();
                            })
                        } else {
                            dup();
                        }
                        break;
                    default:

                }
            });

            // Parents tree
            $parentstree = $("#parents-tree").jstree({
                "core": {
                    "expand_selected_onload": true,
                    "data": {
                        "url": "Ajax/GetParentsTreeJSON.ashx?pk=<% =Pk.ToString() %>&parent=<% = TheParent.ToString() %>"
                    },
                    "themes": {
                        "name": "default",
                        "variant": "responsive"
                    }
                },
                "checkbox": {
                    "three_state": false,
                    "keep_selected_style": false
                },
                "plugins": ["checkbox"]
            })


            /*
                Selecting and deselecting tree elements update #Parents hidden field
            */
            .on('select_node.jstree deselect_node.jstree', function (e, jtree) {
                var node = jtree.node;
                $.mb_selectnode($(this).data('jstree'), node.a_attr['data-pk'], $parentstree.jstree('get_json'), node.state.selected);
                var parents = new Array();
                var selected = $(this).data('jstree').get_selected();
                $.each(selected, function (index, value) {
                    var n = parseInt(value);
                    if ($.inArray(n, parents) == -1)
                        parents.push(n);
                })
                $('#Parents').val(parents.join(','));
                $('#Parents').parents('[role="form"]').mb_submit('pendingChanges', true);
            })
            .on('ready.jstree', function (e, jtree) {
                $('#Parents').parents('[role="form"]').mb_submit('pendingChanges', false);
            });

            //$parentstree.


            /***
            ******************** Translations ******************
            */
            var fillForm = function (form, data) {
                bootbox.confirm('Attenzione! Il Contenuto dei campi verrà ostituito dalla traduzione automatica. Continuare?', function (result) {
                    if (!result)
                        return;
                    for (var prop in data) {
                        var $field = form.find('[name="' + prop + '"]');
                        if ($field.length) {
                            if ($field.data('select2')) {
                                var tmpArray = data[prop].split(',');
                                var tagsArray = [];
                                while (tmpArray.length) {
                                    tagsArray.push(tmpArray.pop().trim());
                                }
                                $field.select2('val', tagsArray);
                            }
                            else
                                $field.val(data[prop]);
                        }
                    }
                });
            };

            /**
            * ------------ Translate with Bing
            **/
            $('[data-action="translate"], [data-action="delete-translation"]').on('click', function (e) {
                e.preventDefault();
                var $me = $(this);
                var action = $me.attr('data-action');
                var $form = $me.parents('[role="form"]');
                var langid = $form.find('[name="LangId"]').val();
                var pk = $form.find('[name="PostPk"]').val();
                var titolo = $("#ExtraInfo1").val();
                if (!titolo)
                    titolo = $("#Titolo").val();
                var testoBreve = $('#TestoBreve').val();
                var testoLungo = $('#TestoLungo').val();
                var tags = $('#Tags').val();
                var param = {};
                if (action == 'translate') {
                    params = {
                        LangId: langid,
                        Pk: pk,
                        Titolo: titolo,
                        TestoBreve: testoBreve,
                        TestoLungo: testoLungo,
                        Tags: tags
                    };
                    $form.spin();
                    $.ajax('Ajax/BingTranslation.ashx',
                        {
                            data: params,
                            dataType: 'json',
                            type: 'POST'
                        })
                        .done(function (data) {
                            if (data.success) {
                                $.growl({
                                    icon: 'fa fa-thumbs-o-up',
                                    title: '',
                                    message: data.msg
                                },
                                {
                                    type: 'success'
                                });
                                fillForm($form, data.data);
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
                        })
                        .fail(function (jqxhr, textStatus, error) {
                            $.growl({
                                icon: 'fa fa-warning',
                                message: textStatus
                            },
                            {
                                type: 'danger'
                            })
                        })
                        .always(function () {
                            $form.spin(false);
                        });
                } else if (action == 'delete-translation') {
                    params = {
                        LangId: langid,
                        Pk: pk,
                        table: 'ANA_TRANSLATION'
                    };
                    bootbox.confirm('Confermi l\'eliminazione della traduzione?', function (result) {
                        if (!result) return;
                        $.ajax('Ajax/Delete.ashx',
                            {
                                data: params,
                                dataType: 'json',
                                type: 'POST'
                            })
                            .done(function (data) {
                                if (data.success) {
                                    $.growl({
                                        icon: 'fa fa-thumbs-o-up',
                                        title: '',
                                        message: data.msg
                                    },
                                    {
                                        type: 'success'
                                    });
                                    $form.find('[name="TranslatedTitle"]').val("");
                                    $form.find('[name="TranslatedTestoBreve"]').val("");
                                    $form.find('[name="TranslatedTestoLungo"]').val("");
                                    $form.find('[name="TranslatedTags"]').select2("val", []);
                                    setTimeout(function () { $form.mb_submit('pendingChanges', false); }, 200);
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
                            })
                            .fail(function (jqxhr, textStatus, error) {
                                $.growl({
                                    icon: 'fa fa-warning',
                                    message: textStatus
                                },
                                {
                                    type: 'danger'
                                })
                            })
                            .always(function () {
                                $form.spin(false);
                            });
                    });
                }

            });

            //End Translations

            //eventi form contenuti
            $form_contents.on('submitted.mb.form', function (e, data) {
                //e.stopPropagation();
                if (data.success) {
                    $table_contenuti.ajax.reload();
                    $.growl({
                        icon: 'fa fa-thumbs-o-up',
                        title: 'Salvataggio dati',
                        message: data.msg
                    },
                    {
                        type: 'success'
                    });
                    // Post Id hidden fields updated !!
                    $('[name="Pk"], [name="PostPk"]').val(data.pk);
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
            })
            .on('changed.mb.form', function (e, pending) {
                var $tabicon = $('a[href="#main-data"] i');
                if (pending)
                    $tabicon.removeClass('hidden');
                else
                    $tabicon.addClass('hidden');
            });

            //Pseudoforms translations
            $('[id^="edit-lang-"]').on('submitted.mb.form', function (e, data) {
                if (data.success) {
                    $.growl({
                        icon: 'fa fa-thumbs-o-up',
                        title: 'Salvataggio dati',
                        message: data.msg
                    },
                    {
                        type: 'success'
                    });
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
            })
            .on('changed.mb.form', function (e, pending) {
                var $this = $(this);
                var langid = $this.find('[name="LangId"]').val();
                var $tabicon = $('a[href="#lang-' + langid + '"] i');
                if (pending)
                    $tabicon.removeClass('hidden');
                else
                    $tabicon.addClass('hidden');
            });

            // Pending changes control
            $(window).on('beforeunload', function () {
                tableContentHistory.save('tableContentHistory');
                var ch = $form_contents.mb_submit('pendingChanges');
                $('[id^="edit-lang-"]').each(function () {
                    if ($(this).mb_submit('pendingChanges'))
                        ch = true;
                });
                if (ch)
                    return 'Attenzione sono state rilevate modifiche non salvate.';
            });

            /*
            *********** Preview modal *****************
            */
            $('#preview-modal').on('show.bs.modal', function (e) {
                var ch = $form_contents.mb_submit('pendingChanges');
                $('[id^="edit-lang-"]').each(function () {
                    if ($(this).mb_submit('pendingChanges'))
                        ch = true;
                });
                
                var $this = $(this);
                var $btn = $(e.relatedTarget);
                var selector = $btn.attr('data-source');
                var url = '';
                var error = '';
                if (!ch) {

                    if ($btn.attr('data-action') == 'show-record')
                        url = '/Contenuti.aspx?p=' + $('#Pk').val();
                    else if ($btn.attr('data-action') == 'show-in-parent') {
                        var p = $('#Parents').val();
                        if (p) {
                            var parents = p.split(',');
                            url = '/Contenuti.aspx?p=' + parents[0];
                        }
                        else {
                            error = 'Il record non ha parents';
                        }
                    }
                }
                else
                    error = 'Per visualizzare una pagina è necessario prima salvare le modifiche';
                var $title = $this.find('.modal-title');
                var $body = $this.find('.modal-body');
                var $dialog = $this
                    .children('.modal-dialog')
                    .removeClass('modal-lg modal-sm')
                if (url) {
                    $title.html($('#Titolo').val());
                    $body.html('');
                        $('<iframe border="0" />')
                            .css({ 'width': '100%', border: 0, display: 'block' })
                            .height($(window).height() * 0.8)
                            .attr('src', url)
                            .appendTo($body);
                } else {
                    $title.html('Avvertenza');
                    $body.html('<h4 class="text-center">' + error+ '</h4>');
                }
            });
        });



    </script>
</asp:Content>
