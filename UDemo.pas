unit UDemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmDemo = class(TForm)
    Button1: TButton;
    Button2: TButton;
    mmResult: TMemo;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDemo: TfrmDemo;

implementation

{$R *.dfm}

uses UTxtCliente,UTxtProduto;

procedure TfrmDemo.Button1Click(Sender: TObject);
var
  txtCliente : TImportaCliente;
  i          : Integer;
begin
  if not OpenDialog1.Execute then
    exit;
  mmResult.Lines.Clear;
  txtCliente := TImportaCliente.create;
  txtCliente.Arquivo := OpenDialog1.FileName;
  txtCliente.importa;
  if txtCliente.Erros.Count<>0 then
  begin
    mmResult.Lines.Text := txtCliente.Erros.Text;
  end
  else
  begin
    for i := 0 to Pred(txtCliente.Clientes.Count) do
    begin
      mmResult.Lines.Add( txtCliente.Clientes[i].versao+', '+
                          txtCliente.Clientes[i].TpDoc+', '+
                          txtCliente.Clientes[i].NumDoc+', '+
                          txtCliente.Clientes[i].xNome+', '+
                          txtCliente.Clientes[i].IE+', '+
                          txtCliente.Clientes[i].ISUF+', '+
                          txtCliente.Clientes[i].xLogr+', '+
                          txtCliente.Clientes[i].Nro+', '+
                          txtCliente.Clientes[i].xCpl+', '+
                          txtCliente.Clientes[i].xBairro+', '+
                          txtCliente.Clientes[i].cMun+', '+
                          txtCliente.Clientes[i].xMun+', '+
                          txtCliente.Clientes[i].UF+', '+
                          txtCliente.Clientes[i].CEP+', '+
                          txtCliente.Clientes[i].cPais+', '+
                          txtCliente.Clientes[i].xPais+' ,'+
                          txtCliente.Clientes[i].Fone );
    end;
    ShowMessage( IntToStr(txtCliente.qtImp)+' clientes listados' );
  end;
  FreeAndNil(txtCliente);
end;

procedure TfrmDemo.Button2Click(Sender: TObject);
var
  txtProduto : TImportaProduto;
  i,j        : Integer;
begin
  if not OpenDialog1.Execute then
    exit;
  mmResult.Lines.Clear;
  txtProduto := TImportaProduto.create;
  txtProduto.Arquivo := OpenDialog1.FileName;
  txtProduto.importa;
  if txtProduto.Erros.Count<>0 then
  begin
    mmResult.Lines.Text := txtProduto.Erros.Text;
  end
  else
  begin
    for i := 0 to Pred(txtProduto.Produtos.Count) do
    begin
      mmResult.Lines.Add( txtProduto.Produtos[i].versao+', '+
                          txtProduto.Produtos[i].cProd+', '+
                          txtProduto.Produtos[i].xProd+', '+
                          txtProduto.Produtos[i].cEAN+', '+
                          txtProduto.Produtos[i].NCM+', '+
                          txtProduto.Produtos[i].EXTIPI+', '+
                          txtProduto.Produtos[i].genero+', '+
                          txtProduto.Produtos[i].uCom+', '+
                          FormatFloat(',0.00',txtProduto.Produtos[i].vUnCom)+', '+
                          txtProduto.Produtos[i].cEANTrib+', '+
                          txtProduto.Produtos[i].uTrib+', '+
                          FormatFloat(',0.00',txtProduto.Produtos[i].vUnTrib)+', '+
                          FormatFloat('0.0000',txtProduto.Produtos[i].qTrib)+', '+
                          txtProduto.Produtos[i].mIpi+', '+
                          IntToStr(txtProduto.Produtos[i].qtdeN)+', '+
                          txtProduto.Produtos[i].CNPJProd+', '+
                          txtProduto.Produtos[i].cEnq );
      for j := 0 to Pred(txtProduto.Produtos[i].ICMS.Count) do
        mmResult.Lines.Add('    ICMS: '+
                            txtProduto.Produtos[i].ICMS[j].CST+', '+
                            txtProduto.Produtos[i].ICMS[j].orig+', '+
                            txtProduto.Produtos[i].ICMS[j].modBC+', '+
                            FormatFloat(',0.00',txtProduto.Produtos[i].ICMS[j].pICMS)+', '+
                            FormatFloat(',0.00',txtProduto.Produtos[i].ICMS[j].pRedBC)+', '+
                            FormatFloat(',0.00',txtProduto.Produtos[i].ICMS[j].modBCST)+', '+
                            FormatFloat(',0.00',txtProduto.Produtos[i].ICMS[j].pRedBCST)+', '+
                            FormatFloat(',0.00',txtProduto.Produtos[i].ICMS[j].pMVAST) );
    end;
    ShowMessage( IntToStr(txtProduto.qtImp)+' produtos listados' );
  end;
  FreeAndNil(txtProduto);
end;

end.
