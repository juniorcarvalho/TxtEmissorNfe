unit UTXTCliente;

interface

uses Classes, Contnrs, SysUtils, StrUtils;

type
  TClienteModel = class
  private
    fVersao : String;
    fTpDoc  : String;
    fNumDoc : String;
    fxNome  : String;
    fIE     : String;
    fISUF   : String;
    fxLogr  : String;
    fNro    : String;
    fxCpl   : String;
    fxBairro: String;
    fcMun   : String;
    fxMun   : String;
    fUF     : String;
    fCEP    : String;
    fcPais  : String;
    fxPais  : String;
    fFone   : String;
  published
    property versao : String read fVersao  write fVersao;
    property TpDoc  : String read fTpDoc   write fTpDoc;
    property NumDoc : String read fNumDoc  write fNumDoc;
    property xNome  : String read fxNome   write fxNome;
    property IE     : String read fIE      write fIE;
    property ISUF   : String read fISUF    write fISUF;
    property xLogr  : String read fxLogr   write fxLogr;
    property Nro    : String read fNro     write fNro;
    property xCpl   : String read fxCpl    write fxCpl;
    property xBairro: String read fxBairro write fxBairro;
    property cMun   : String read fcMun    write fcMun;
    property xMun   : String read fxMun    write fxMun;
    property UF     : String read fUF      write fUF;
    property CEP    : String read fCEP     write fCEP;
    property cPais  : String read fcPais   write fcPais;
    property xPais  : String read fxPais   write fxPais;
    property Fone   : String read fFone    write fFone;
  end;

  TListadeClientes = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TClienteModel);
    function  GetObject (Index: Integer): TClienteModel;
    procedure Insert (Index: Integer; Obj: TClienteModel);
  public
    function Add (Obj: TClienteModel): Integer;
    property Objects [Index: Integer]: TClienteModel
      read GetObject write SetObject; default;
  end;

  TImportaCliente = class
  private
    fArquivo  : String;
    fErros    : TStringList;
    fClientes : TListadeClientes;
    fQtReg    : Integer;
    fQtImp    : Integer;
    procedure StringToArray(St: string; Separador: char; Lista: TStringList);
  public
    constructor create;
    destructor destroy;override;
    procedure importa;
  published
    property Arquivo : String           read fArquivo  write fArquivo;
    property Erros   : TStringList      read fErros    write fErros;
    property Clientes: TListadeClientes read fClientes write fClientes;
    property qtReg   : Integer          read fQtReg;
    property qtImp   : Integer          read fQtImp;
  end;

implementation

{ TImportaCliente }

constructor TImportaCliente.create;
begin
  fErros    := TStringList.Create;
  fClientes := TListadeClientes.Create(True);
end;

destructor TImportaCliente.destroy;
begin
  FreeAndNil(fErros);
  FreeAndNil(fClientes);
  inherited;
end;

procedure TImportaCliente.importa;
var
  conteudoArquivo : TStringList;
  linha           : TStringList;
  cliente         : TClienteModel;
  i               : Integer;
begin
  if not FileExists(Arquivo) then
  begin
    Erros.Add('Arquivo '+Arquivo+' não encontrado.');
    exit;
  end;
  conteudoArquivo := TStringList.Create;
  conteudoArquivo.LoadFromFile(Arquivo);
  if LeftStr(conteudoArquivo[0],8) <> 'CLIENTE|' then
  begin
    Erros.Add('Layout do arquivo '+Arquivo+' inválido');
    exit;
  end;
  linha := TStringList.Create;
  StringToArray(conteudoArquivo[0],'|',linha);
  fQtReg := StrToIntDef(linha[1],0);
  if fQtReg=0 then
  begin
    Erros.Add('Nenhum registro para importar.');
    exit;
  end;
  fQtImp := 0;
  for i := 1 to Pred(conteudoArquivo.Count) do
  begin
    linha.Clear;
    StringToArray( conteudoArquivo[i],'|',linha);
    if linha[0]='A' then
      Continue
    else if linha[0]='E' then
    begin
      if linha.Count<17 then
      begin
        Erros.Add('Linha inválida.('+IntToStr(i)+')');
        Continue;
      end;
      cliente         := TClienteModel.Create;
      cliente.TpDoc   := linha[1];
      cliente.NumDoc  := linha[2];
      cliente.xNome   := linha[3];
      cliente.IE      := linha[4];
      cliente.ISUF    := linha[5];
      cliente.xLogr   := linha[6];
      cliente.Nro     := linha[7];
      cliente.xCpl    := linha[8];
      cliente.xBairro := linha[9];
      cliente.cMun    := linha[10];
      cliente.xMun    := linha[11];
      cliente.UF      := linha[12];
      cliente.CEP     := linha[13];
      cliente.cPais   := linha[14];
      cliente.xPais   := linha[15];
      cliente.Fone    := linha[16];
      Clientes.Add(cliente);
      Inc(fQtImp);
    end;
  end;
  FreeAndNil(conteudoArquivo);
  FreeAndNil(linha);
end;

procedure TImportaCliente.StringToArray(St: string; Separador: char;
  Lista: TStringList);
var
  I: Integer;
begin
  Lista.Clear;
  if St <> '' then
  begin
    St := St + Separador;
    I := Pos(Separador, St);
    while I > 0 do
    begin
      Lista.Add(Copy(St, 1, I - 1));
      Delete(St, 1, I);
      I := Pos(Separador, St);
    end;
  end;
end;

{ TListadeClientes }

function TListadeClientes.Add(Obj: TClienteModel): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TListadeClientes.GetObject(Index: Integer): TClienteModel;
begin
  Result := inherited GetItem(Index) as TClienteModel;
end;

procedure TListadeClientes.Insert(Index: Integer; Obj: TClienteModel);
begin
  inherited Insert(Index, Obj);
end;

procedure TListadeClientes.SetObject(Index: Integer; Item: TClienteModel);
begin
   inherited SetItem (Index, Item) ;
end;

end.
