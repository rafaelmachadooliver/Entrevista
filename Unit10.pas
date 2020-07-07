unit Unit10;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, DBCtrls, DB, Grids, DBGrids, Buttons, Mask,
  ExtCtrls, dialogs, unit2, unit28, unit5, unit30, Spin,
  IBCustomDataSet, IBQuery, IBUpdateSQL,
  IBSQL, Provider, DBClient, ACBrBase, ACBrEnterTab;

type
  TForm10 = class(TForm)
    ScrollBox: TScrollBox;
    Label1: TLabel;
    Editsequen: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    Editclient: TDBEdit;
    Panel1: TPanel;
    DataSource1: TDataSource;
    Panel2: TPanel;
    Panel3: TPanel;
    DBText1: TDBText;
    SpeedButton1: TSpeedButton;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DataSource4: TDataSource;
    Label13: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DataSource5: TDataSource;
    BitBtn3: TBitBtn;
    DataSource6: TDataSource;
    DataSource7: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DataSource8: TDataSource;
    DataSource9: TDataSource;
    BitBtn4: TBitBtn;
    Label24: TLabel;
    SpinEdit1: TSpinEdit;
    DataSource10: TDataSource;
    DataSource11: TDataSource;
    Label26: TLabel;
    Label27: TLabel;
    DBNavigator1: TDBNavigator;
    Label28: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    BtnVendendores: TBitBtn;
    DsProfissional: TDataSource;
    btnEdit: TBitBtn;
    dbedtComanda: TDBEdit;
    lbl2: TLabel;
    DbComboTipo: TDBComboBox;
    lbl1: TLabel;
    dbedtdata: TDBEdit;
    BitBtn5: TBitBtn;
    btnDeletaItem: TBitBtn;
    Edit1: TEdit;
    ScrollBox1: TScrollBox;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    DBGrid3: TDBGrid;
    DBEdit3: TDBEdit;
    Panel4: TPanel;
    DBEdit5: TDBEdit;
    Edit2: TEdit;
    Edit5: TEdit;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    Edit6: TEdit;
    Label18: TLabel;
    Label17: TLabel;
    DBEdit8: TDBEdit;
    RadioGroup1: TRadioGroup;
    Panel5: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label16: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    lblStatus: TLabel;
    PnForma: TPanel;
    Label5: TLabel;
    Label23: TLabel;
    Edit7: TEdit;
    Edit8: TEdit;
    Label25: TLabel;
    procedure EditsequenKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure DBGrid1ColExit(Sender: TObject);
    procedure DBGrid2Exit(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure EditclientExit(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure EditvendedExit(Sender: TObject);
    procedure DBGrid1EditButtonClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid2Enter(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure IBQuery1AfterInsert(DataSet: TDataSet);
    procedure BitBtn5Click(Sender: TObject);
    procedure ClientDataSet1AfterScroll(DataSet: TDataSet);
    procedure GridVendedoresExit(Sender: TObject);
    procedure Edit4Enter(Sender: TObject);
    procedure btnDeletaItemClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnApagarProfissionalClick(Sender: TObject);
    procedure DBEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbedtComandaExit(Sender: TObject);
    procedure dbedtComandaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditclientKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Edit8KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit7KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { private declarations }
    procedure TotalVenda;
    Procedure GeraParcela;
    procedure DifValores; 
  public
    { public declarations }
  end;

var
  Form10: TForm10;
  f, vseque, I: integer;
  vgrav, Atual: string;
  avalor: real;
  total: real;
  MV: array [1 .. 80] of String;

implementation

uses Unit29, Unit6, Unit31, Unit32, Unit72, Unit77, Unit1, Unit7, U_ItensVenda,
  U_DmVendas;

{$R *.DFM}

procedure TForm10.EditsequenKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = VK_RETURN then
     begin
          if Edit6.Text <> '' then
           begin
              DmVendas.IBQueryAux.Close;
              DmVendas.IBQueryAux.SQL.Clear;
              DmVendas.IBQueryAux.SQL.Add('Select Codigo, Nome, Venda from Estoque '+
                                          'where codigo =:cod ');
              DmVendas.IBQueryAux.ParamByName('cod').AsInteger:= StrToInt(Edit6.Text);
              DmVendas.IBQueryAux.Open;
              
              if DmVendas.IBQueryAux.IsEmpty then
                 begin
                    ShowMessage('Produto não cadastrado.');
                    Edit6.Clear;
                    exit;
                 end
                 else
                  begin
                     DmVendas.IBQuery2.Append;
                     Dmvendas.IBquery2.fieldbyname('codigo').AsInteger:= DmVendas.IBQueryAux.FieldByName('Codigo').AsInteger;
                     Dmvendas.IBQuery2.FieldByName('QTD').AsInteger:= 1;
                     Dmvendas.IBQuery2.fieldbyname('unit').AsString:= DmVendas.IBQueryAux.FieldByName('Venda').AsString;
                     DBGrid1.SelectedIndex:=2;
                     DBGrid1.SelectedIndex:=3;
                     TotalVenda;
                     Edit6.Clear;
                     Edit6.SetFocus;
                  end;
           end;   
     end;

  if Key = VK_F2 then
     Edit2.SetFocus;
end;

procedure TForm10.FormShow(Sender: TObject);
begin

  DmVendas.IBQuery1.Active := true;
  DmVendas.QryProfissional.Active:= true;
  DmVendas.IBQuery2.Active := true;
  DmVendas.IBQuery3.Active := true;
  DmVendas.IBQuery4.Active := true;
  DmVendas.IBQuery6.Active := true;
  DmVendas.IBQuery7.Active := true;
  DmVendas.IBQuery12.Active := true;
  DmVendas.IBQuery13.Active := true;
  DmVendas.IBQuery14.Active := true;
  DmVendas.IBQuery16.Active := true;

  DmVendas.QryConsulta.Close;
  DmVendas.QryConsulta.SQL.Clear;
  DmVendas.QryConsulta.SQL.Add('Select Codigo, usuario from Senhas ' + 'where usuario =:usu ');
  DmVendas.QryConsulta.ParamByName('usu').asstring := form21.IBQuery1.fieldbyname
    ('usuario').asstring;
  DmVendas.QryConsulta.Open;
  Label12.caption := DmVendas.QryConsulta.FieldByName('usuario').AsString; 
  
end;

procedure TForm10.GridVendedoresExit(Sender: TObject);
var
 Contador:Integer;
begin
   DmVendas.QryProfissional.DisableControls;
   DmVendas.QryProfissional.First;
   while not DmVendas.QryProfissional.Eof do
     begin
         Contador:= Contador + 1;
         DmVendas.QryProfissional.Next;
     end;
   DmVendas.QryProfissional.EnableControls;   
end;

procedure TForm10.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DmVendas.IBQuery1.Active := false;
  DmVendas.QryProfissional.Active:= false;
  DmVendas.IBQuery2.Active := false;
  DmVendas.IBQuery3.Active := false;
  DmVendas.IBQuery4.Active := false;
  DmVendas.IBQuery6.Active := false;
  DmVendas.IBQuery7.Active := false;
  DmVendas.IBQuery12.Active := false;
  DmVendas.IBQuery13.Active := false;
  DmVendas.IBQuery14.Active := false;
  DmVendas.IBQuery16.Active := false;
end;

procedure TForm10.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

   if key = VK_F1 then
      if lblStatus.Caption <> 'VENDA ABERTA' then      
        BitBtn4.OnClick(BitBtn4);

   if not DmVendas.IBQuery2.IsEmpty then
     begin
        if key = VK_F10 then
          BitBtn1.OnClick(BitBtn1);         

        if key = VK_F5 then
          RadioGroup1.ItemIndex:= 0;

        if key = VK_F6 then
          RadioGroup1.ItemIndex:= 1;

        if key = VK_F7 then
          RadioGroup1.ItemIndex:= 2;
          
        if key = VK_F8 then
          RadioGroup1.ItemIndex:= 3;
     end;            
end;

procedure TForm10.BitBtn1Click(Sender: TObject);
var
operacao:string;
begin
   if RadioGroup1.ItemIndex = -1 then
     begin
       Application.MessageBox('Escolha uma forma de Pagamento.', 'Pdv', MB_ICONINFORMATION);
       exit;
     end;     

   if DmVendas.IBQuery1.State in [dsEdit,dsInsert] then
     begin        
        GeraParcela;
        vgrav := 'S';
        operacao:='V';
        DmVendas.IBQuery16.Close;
        DmVendas.IBQuery16.SQL.Clear;
        DmVendas.IBQuery16.SQL.Add('Select * from Estoque, mvven00 ' +
                                   'where Estoque.codigo = mvven00.codigo ' + 'and mvven00.seque =:code ');
        DmVendas.IBQuery16.ParamByName('code').AsInteger := Editsequen.Field.AsInteger;
        DmVendas.IBQuery16.Open;
        if (DmVendas.IBQuery1OPERAC.value = 'S') or (DmVendas.IBQuery1OPERAC.value = 'V') then
        begin
           if DBEdit2.text = '' then
             DBEdit2.setfocus;
           //ScrollBox.enabled := false;
        end
        else
          begin
             //ScrollBox.enabled := true;
          end;
        // * Data: 28/02/2012 - Tela de Pedidos - Inicio.
        if operacao = 'P' then // Pedido
        begin
          DmVendas.IBQuery2.First;
          while not DmVendas.IBQuery2.eof do
            begin
               DmVendas.IBQuery16.edit; // Era Ibquery16
               DmVendas.IBQuery16.Post;
               DmVendas.IBQuery12.First;
               while not DmVendas.IBQuery12.eof do
                 begin
                    DmVendas.IBQuery13.edit;
                    DmVendas.IBQuery13.Post;
                    DmVendas.IBQuery12.next;
                 end;
               DmVendas.IBQuery2.next;
            end;
        end;
        // Baixa de Estoque
        if operacao = 'V' then // Venda.
        begin
          DmVendas.IBQuery2.First;
          while not DmVendas.IBQuery2.eof do
            begin
               if DmVendas.IBQuery16.FieldByName('ProdServ').AsString ='P' then
                 begin
                    DmVendas.IBQuery16.edit; // Era Ibquery16
                    DmVendas.IBQuery16.fieldbyname('saldo').asfloat := DmVendas.IBQuery16.fieldbyname('saldo').asfloat - DmVendas.IBQuery2QTD.value;
                    DmVendas.IBQuery16.Post;
                 end;
               DmVendas.IBQuery16.next;

               while not DmVendas.IBQuery12.eof do
                 begin
                    DmVendas.IBQuery13.edit;
                    DmVendas.IBQuery13.fieldbyname('saldo').asfloat := DmVendas.IBQuery13.fieldbyname('saldo')
                      .asfloat - (DmVendas.IBQuery12QTD.value * DmVendas.IBQuery2QTD.value);
                    DmVendas.IBQuery13.Post;
                    DmVendas.IBQuery12.next;
                 end;

               DmVendas.IBQuery2.next;
            end;
          { grava contas a receber }
          DmVendas.IBQuery3.First;
          while not DmVendas.IBQuery3.eof do
          begin
            DmVendas.Ibquery14.Append;
            DmVendas.IBQuery14.fieldbyname('valor').asfloat := DmVendas.IBQuery3VALOR.value;
            DmVendas.IBQuery14.fieldbyname('data').asdatetime := DmVendas.IBQuery1DATA.value;

            if DmVendas.IBQuery3CHEQUE.value <> '' then
              DmVendas.IBQuery14TIPODOC.value := 'C';

            if DmVendas.IBQuery3CHEQUE.value = '' then
              DmVendas.IBQuery14TIPODOC.value := 'V';

            DmVendas.IBQuery14ORCAM.AsString := Editsequen.text;
            DmVendas.IBQuery14CHEQUE.value := DmVendas.IBQuery3CHEQUE.value;
            DmVendas.IBQuery14BANCO.value := DmVendas.IBQuery3BANCO.value;
            DmVendas.IBQuery14CODCLIE.value := DmVendas.IBQuery1CLIENT.value;
            DmVendas.IBQuery14VECTO.value := DmVendas.IBQuery3VENCIM.value;
            DmVendas.IBQuery14FATURA.value := DmVendas.IBQuery1SEQUEN.AsString + '/' +
              DmVendas.IBQuery3LANC.AsString;
            if (DmVendas.IBQuery3VENCIM.value <= date) then // *09/10/2019 - Nova regra colocada para o Salão Data Menor.
            begin
              DmVendas.IBQuery14RECEBTO.value := DmVendas.IBQuery3VENCIM.value;
              DmVendas.IBQuery14VALORREC.value := DmVendas.IBQuery3VALOR.value;
            end;
            DmVendas.IBQuery14.Post;
            DmVendas.IBQuery3.next;
          end;
        end;
        DmVendas.IBQuery1HORA.value := time;
        DmVendas.IBQuery1.Post;
        DBGrid1.enabled := false;
        DBGrid2.enabled := false;
        Edit2.Clear;
        Edit5.Clear;
        Application.MessageBox('Venda Finalizada com sucesso.', 'Pdv', MB_ICONINFORMATION);
        RadioGroup1.ItemIndex:= -1;
        lblStatus.Caption:='VENDA FINALIZADA';
        lblStatus.Font.Color:= clBlack;
     end;
end;

procedure TForm10.DBGrid1ColExit(Sender: TObject);
begin
  if not DmVendas.IBQuery2.IsEmpty then
    begin
        if DmVendas.IBQuery2.fieldbyname('codigo').AsString <> '' then
        begin
          if DmVendas.IBQuery4.Locate('codigo', DmVendas.IBQuery2CODIGO.value,
            [loCaseInsensitive, loPartialKey]) = false then
            showmessage('Produto não Cadastrado !!!')
          else
          begin
            DmVendas.IBQuery2.edit;
            DmVendas.IBQuery2.fieldbyname('seque').AsInteger := DmVendas.IBQuery1SEQUEN.value;
            //IBQuery2.fieldbyname('unit').asfloat := IBQuery4VENDA.value; // Era Table4
            DmVendas.IBQuery2DATA.value := DmVendas.IBQuery1DATA.value;      
          end;
        end;
    end;
end;

procedure TForm10.DBGrid2Exit(Sender: TObject);
var
  t: real;
begin
  vgrav := 'N';
  t := 0;
  DmVendas.IBQuery3.First;
  while not DmVendas.IBQuery3.eof do
  begin
    t := t + DmVendas.IBQuery3VALOR.value;
    DmVendas.IBQuery3.next;
  end;
  DmVendas.IBQuery1.edit;
  DmVendas.IBQuery1.fieldbyname('treceb').asfloat := t;
  if DBEdit1.text <> DBEdit2.text then
  begin
    if Messagedlg('Existe Diferença nos Valores, Aceita ?', mtconfirmation,
      [mbyes, mbno], 0) = mrno then
      DBGrid2.setfocus
  end;

end;

procedure TForm10.SpeedButton1Click(Sender: TObject);
begin
  form14 := tform14.create(self);
  Unit29.X5 := 2;
  form14.showmodal;
  form14.release;
end;

procedure TForm10.EditclientExit(Sender: TObject);
begin
  DmVendas.IBQueryAux.Close;
  DmVendas.IBQueryAux.SQL.Clear;
  DmVendas.IBQueryAux.SQL.Add('Select * from cliente where codigo=:ag');
  DmVendas.IBQueryAux.ParamByName('ag').AsInteger := Editclient.Field.AsInteger;
  DmVendas.IBQueryAux.Open;
  Label28.Caption := DmVendas.IBQueryAux.fieldbyname('Nome').AsString;
  DmVendas.IBQuery1.Post;
  DmVendas.IBQuery1.edit;
end;

procedure TForm10.EditclientKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_RETURN then   
     DBComboTipo.SetFocus;
end;

procedure TForm10.SpeedButton5Click(Sender: TObject);
begin
  { form20:=tform20.create(self);
    form20.showmodal;
    form20.release; }
end;

procedure TForm10.SpeedButton2Click(Sender: TObject);
begin
  form19 := tform19.create(self);
  Unit31.X6 := 2;
  form19.showmodal;
  form19.release;
end;

procedure TForm10.EditvendedExit(Sender: TObject);
begin
 {
  if IBQuery7.Locate('codigo', Editvended.text,
    [loCaseInsensitive, loPartialKey]) = false then
  begin
    showmessage('Vendedor não Cadastrado !!!');
  end; }

  //DBComboTipo.setfocus;
end;

procedure TForm10.DBGrid1EditButtonClick(Sender: TObject);
begin
  DmVendas.IBQuery2.edit;
  form6 := tform6.create(self);
  Unit6.x4 := 7;
  form6.showmodal;
  form6.release;
end;

procedure TForm10.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_f2 then
    SpinEdit1.setfocus;
end;

procedure TForm10.DBGrid2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_f2 then
    BitBtn1.setfocus;
end;

procedure TForm10.Edit3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = VK_RETURN then
     Edit4.SetFocus;
end;

procedure TForm10.DBGrid2Enter(Sender: TObject);
begin
  if DmVendas.IBQuery3.fieldbyname('vencim').AsString = '' then
  begin
    DmVendas.IBQuery3.edit;
    DmVendas.IBQuery3VENCIM.value := date;
  end;
end;

procedure TForm10.BitBtn4Click(Sender: TObject);
begin
  DmVendas.IBQuery1.Append;
  DmVendas.IBQuery1.FieldByName('Data').AsDateTime:= now;
  DmVendas.IBQuery1.Post;
  DmVendas.IBQuery1.edit;
  lblStatus.Font.Color:= clLime;
  lblStatus.Caption:='VENDA ABERTA';
  Edit6.SetFocus;
end;

procedure TForm10.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm10.dbedtComandaExit(Sender: TObject);
begin
   if DmVendas.IBQuery1.FieldByName('CodComanda').AsString ='' then
     begin
        ShowMessage('Preencha o código da comanda.');
        dbedtComanda.SetFocus;
        exit;
     end;

     DmVendas.IBQueryAux.Close;
     DmVendas.IBQueryAux.sql.Clear;
     DmVendas.IBQueryAux.sql.Add('Select CodComanda from Ven00 '+
                        'where codComanda =:cod ');
     DmVendas.IBQueryAux.ParamByName('Cod').AsString:= DmVendas.Ibquery1.FieldByName('CodComanda').AsString;
     DmVendas.IBQueryAux.Open;
     if not DmVendas.IBQueryAux.IsEmpty then                                
       begin
         ShowMessage('Este código já está cadastrado');
         dbedtComanda.SetFocus;
         exit; 
       end;
end;

procedure TForm10.dbedtComandaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = VK_RETURN then
     Editclient.SetFocus;
end;

procedure TForm10.DBEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = VK_RETURN then
     SpinEdit1.SetFocus;
end;

procedure TForm10.IBQuery1AfterInsert(DataSet: TDataSet);
begin
  ScrollBox.enabled := true;
end;

procedure TForm10.RadioGroup1Click(Sender: TObject);
var
  valor:string;
begin
  case RadioGroup1.ItemIndex of
     0://Dinheiro
       begin
          DmVendas.IBQuery1.fieldbyname('Forma').AsString := 'DINHEIRO';
          Edit2.SetFocus;
       end;
     1://Cheque
       begin
           DmVendas.IBQuery1.fieldbyname('Forma').AsString := 'CHEQUE';
           Edit2.Text:= DmVendas.IBQuery1.FieldByName('Tvendas').AsString;
       end;
      2://Debito
       begin          
          valor := inputbox('Tipo de pagamento', '1 PARA PAGAMENTO TOTAL'+#13+
                                                 '2 PARA PAGAMENTO PARCIAL:'
                                                  +#13,'');
          if valor = '1' then
            begin
               DmVendas.IBQuery1.fieldbyname('Forma').AsString := 'DEBITO';
               Edit2.Text:= DmVendas.IBQuery1.FieldByName('Tvendas').AsString;
            end;
          if valor = '2' then          
          begin
            PnForma.Visible:=true;
            Edit7.SetFocus;            
          end;  
       end;
      3://Credito
       begin
          DmVendas.IBQuery1.fieldbyname('Forma').AsString := 'CREDITO';            
          Edit2.Text:= DmVendas.IBQuery1.FieldByName('Tvendas').AsString;
       end;
  end;  
end;

procedure TForm10.BitBtn5Click(Sender: TObject);
begin
  DmVendas.IBQuery2.Append;
  FrmItensVenda:=TFrmItensVenda.create(self);
  FrmItensVenda.showmodal;
  FrmItensVenda.release;
  DBGrid1.SelectedIndex:=2;
  DBGrid1.SelectedIndex:=3;
  TotalVenda;
  Dbedit1.SetFocus;
end;

procedure TForm10.btnApagarProfissionalClick(Sender: TObject);
begin
   DmVendas.QryProfissional.Delete;
end;

procedure TForm10.btnDeletaItemClick(Sender: TObject);
begin
   DmVendas.IBQuery2.Delete;
   TotalVenda;
end;

procedure TForm10.btnEditClick(Sender: TObject);
begin
   DmVendas.Ibquery1.edit;
end;

procedure TForm10.ClientDataSet1AfterScroll(DataSet: TDataSet);
begin
  {IBQuery2.Close;
  IBQuery2.SQL.Clear;
  IBQuery2.SQL.Add('Select MVven00.seque, MVven00.codigo,' +
    'MVven00.QTD, MVven00.UNIT, MVven00.Vende2, MVven00.Data ' +
    'from MVven00,ven00 ' + 'where Mvven00.seque =Ven00.sequen ' +
    'and Ven00.sequen =:cod ');
  IBQuery2.ParamByName('cod').AsString := Editsequen.Field.AsString;
  IBQuery2.Open;

  IBQuery3.Close;
  IBQuery3.SQL.Clear;
  IBQuery3.SQL.Add('Select * from Venc00, ven00 ' +
    'where Venc00.seque = ven00.sequen ' + 'and Ven00.sequen =:codi');
  IBQuery3.ParamByName('codi').AsString := Editsequen.Field.AsString;
  IBQuery3.Open;}
end;

procedure TForm10.Edit4Enter(Sender: TObject);
var
  Valor1, Resultado: Currency;
begin
  Valor1 := StrToFloat(Edit2.text);
  Resultado := (Valor1 - Dmvendas.IBQuery1.fieldbyname('TVendas').AsCurrency);
  if Resultado > 0 then  
    Edit5.text := FloatToStr(Resultado);
end;

procedure TForm10.Edit7KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = VK_RETURN then
     Edit8.SetFocus;
end;

procedure TForm10.Edit8KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = VK_RETURN then
     DifValores;     
end;

procedure TForm10.TotalVenda;
var
  Total: real;
begin
  Total := 0;
  Dmvendas.IBQuery2.First; // Verificar Aqui.
  while not Dmvendas.IBQuery2.eof do
  begin
    Total := Total + Dmvendas.IBQuery2total.value;
    Dmvendas.IBQuery2.next;
  end;
  Dmvendas.IBQuery1.edit;
  Dmvendas.IBQuery1.fieldbyname('tvendas').asfloat := Total + Dmvendas.IBQuery1VEXEC.value;

  if DBComboTipo.text = 'DINHEIRO' then
    Edit3.text := DBEdit1.text;
end;

Procedure TForm10.GeraParcela;
var
  I: integer;
  vdta: tdatetime;
begin
  Try
    vdta := date - 30;    
    for I := 1 to 1 do
    begin
      DmVendas.IBQuery3.Append;
      DmVendas.IBQuery3.fieldbyname('seque').AsInteger := DmVendas.IBQuery1SEQUEN.value;
      DmVendas.IBQuery3LANC.value := DmVendas.IBQuery3.recordcount + 1;
      if DmVendas.IBQuery1CLIENT.value > 0 then
      begin
        if dateTostr(DmVendas.IBQuery6NASC.value) = '11/11/1111' then
        begin
          if (DmVendas.IBQuery1OPERAC.value = 'S') then
            DmVendas.IBQuery3VENCIM.value := DmVendas.Ibquery1.FieldByName('Data').AsDateTime + 1 //date + 1
          else
            DmVendas.IBQuery3VENCIM.value := DmVendas.Ibquery1.FieldByName('Data').AsDateTime +1; //date + 1;
        end
        else
          DmVendas.IBQuery3VENCIM.value := vdta + 30;
      end
      else
        DmVendas.IBQuery3VENCIM.value := vdta + 30;

      DmVendas.IBQuery3VALOR.value := DmVendas.IBQuery1TVENDAS.value / 1;
      DmVendas.IBQuery3.Post;      
      vdta := DmVendas.IBQuery3VENCIM.value;
    end;   
  Except
    Messagedlg('Erro ao gravar os dados!', mterror, [mbOk], 0);
    Raise;
  end;

end;

procedure TForm10.DifValores; 
var
total:Real;
begin
   total:=  StrToFloat(Edit7.Text) + StrToFloat(Edit8.Text);
   if total = DmVendas.IBQuery1.FieldByName('TVendas').AsFloat then
     begin
        edit7.Clear;
        edit8.Clear;
        PnForma.Visible:=false;
        Edit2.Text:= DmVendas.IBQuery1.FieldByName('TVendas').AsString;          
     end
   else
     begin
        Application.MessageBox('Valores diferem do total.', 'Pdv', MB_ICONINFORMATION);  
        Edit7.SetFocus;
        exit;
     end;     
end; 

end.
