unit UTXTProduto;

interface

uses Classes, Contnrs, SysUtils, StrUtils;

type
  TProdutoICMS = class;

  TProdutoModel = class
  private
    fVersao   : String;
    fcProd    : String;
    fxProd    : String;
    fcEAN     : String;
    fNCM      : String;
    fEXTIPI   : String;
    fGenero   : String;
    fuCom     : String;
    fvUnCom   : Double;
    fcEANTrib : String;
    fuTrib    : String;
    fvUnTrib  : Double;
    fqTrib    : Double;
    //
    fmIpi     : String;
    fqtdeN    : Integer;
    //
    fclEnq    : String;
    fCNPJProd : String;
    fcEnq     : String;
    //
    fICMS     : TProdutoICMS;
  public
    constructor create;
    destructor destroy;override;
  published
    property versao   : string  read fVersao    write fVersao;
    property cProd    : String  read fcProd     write fcProd;
    property xProd    : String  read fxProd     write fxProd;
    property cEAN     : String  read fcEAN      write fcEAN;
    property NCM      : String  read fNCM       write fNCM;
    property EXTIPI   : String  read fEXTIPI    write fEXTIPI;
    property genero   : String  read fGenero    write fGenero;
    property uCom     : String  read fuCom      write fuCom;
    property vUnCom   : Double  read fvUnCom    write fvUnCom;
    property cEANTrib : String  read fcEANTrib  write fcEANTrib;
    property uTrib    : String  read fuTrib     write fuTrib;
    property vUnTrib  : Double  read fvUnTrib   write fvUnTrib;
    property qTrib    : Double  read fqTrib     write fqTrib;
    property mIpi     : String  read fmIpi      write fmIpi;
    property qtdeN    : Integer read fqtdeN     write fqtdeN;
    property clEnq    : String  read fclEnq     write fclEnq;
    property CNPJProd : String  read fCNPJProd  write fCNPJProd;
    property cEnq     : String  read fcEnq      write fcEnq;
    property ICMS     : TProdutoICMS read fICMS write fICMS;
  end;

  TICMS = class
  private
    fCST      : String;
    forig     : String;
    fmodBC    : String;
    fpICMS    : Double;
    fpRedBC   : Double;
    fmodBCST  : Double;
    fpRedBCST : Double;
    fpMVAST   : Double;
  published
    property CST      : String read fCST      write fCST;
    property orig     : String read forig     write forig;
    property modBC    : String read fmodBC    write fmodBC;
    property pICMS    : Double read fpICMS    write fpICMS;
    property pRedBC   : Double read fpRedBC   write fpRedBC;
    property modBCST  : Double read fmodBCST  write fmodBCST;
    property pRedBCST : Double read fpRedBCST write fpRedBCST;
    property pMVAST   : Double read fpMVAST   write fpMVAST;
  end;

  TListadeProdutos = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TProdutoModel);
    function  GetObject (Index: Integer): TProdutoModel;
    procedure Insert (Index: Integer; Obj: TProdutoModel);
  public
    function Add (Obj: TProdutoModel): Integer;
    property Objects [Index: Integer]: TProdutoModel
      read GetObject write SetObject; default;
  end;

  TProdutoICMS = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TICMS);
    function  GetObject (Index: Integer): TICMS;
    procedure Insert (Index: Integer; Obj: TICMS);
  public
    function Add (Obj: TICMS): Integer;
    property Objects [Index: Integer]: TICMS
      read GetObject write SetObject; default;
  end;

  TImportaProduto = class
  private
    fArquivo  : String;
    fErros    : TStringList;
    fProdutos : TListadeProdutos;
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
    property Produtos: TListadeProdutos read fProdutos write fProdutos;
    property qtReg   : Integer          read fQtReg;
    property qtImp   : Integer          read fQtImp;
  end;


implementation

{ TListadeProdutos }

function TListadeProdutos.Add(Obj: TProdutoModel): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TListadeProdutos.GetObject(Index: Integer): TProdutoModel;
begin
  Result := inherited GetItem(Index) as TProdutoModel;
end;

procedure TListadeProdutos.Insert(Index: Integer; Obj: TProdutoModel);
begin
  inherited Insert(Index, Obj);
end;

procedure TListadeProdutos.SetObject(Index: Integer; Item: TProdutoModel);
begin
  inherited SetItem (Index, Item) ;
end;

{ TProdutosICMS }

function TProdutoICMS.Add(Obj: TICMS): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TProdutoICMS.GetObject(Index: Integer): TICMS;
begin
  Result := inherited GetItem(Index) as TICMS;
end;

procedure TProdutoICMS.Insert(Index: Integer; Obj: TICMS);
begin
  inherited Insert(Index, Obj);
end;

procedure TProdutoICMS.SetObject(Index: Integer; Item: TICMS);
begin
  inherited SetItem (Index, Item) ;
end;

{ TProduto }

constructor TProdutoModel.create;
begin
  fICMS := TProdutoICMS.Create(True);
end;

destructor TProdutoModel.destroy;
begin
  FreeAndNil(fICMS);
  inherited;
end;

{ TImportaProduto }

constructor TImportaProduto.create;
begin
  fErros    := TStringList.Create;
  fProdutos := TListadeProdutos.Create;
end;

destructor TImportaProduto.destroy;
begin
  FreeAndNil(fErros);
  FreeAndNil(fProdutos);
  inherited;
end;

procedure TImportaProduto.importa;
var
  conteudoArquivo : TStringList;
  linha1          : TStringList;
  produto         : TProdutoModel;
  icms            : TICMS;
  i               : Integer;
begin
  if not FileExists(Arquivo) then
  begin
    Erros.Add('Arquivo '+Arquivo+' não encontrado.');
    exit;
  end;
  conteudoArquivo := TStringList.Create;
  conteudoArquivo.LoadFromFile(Arquivo);
  if LeftStr(conteudoArquivo[0],8) <> 'PRODUTO|' then
  begin
    Erros.Add('Layout do arquivo '+Arquivo+' inválido');
    exit;
  end;
  linha1 := TStringList.Create;
  StringToArray(conteudoArquivo[0],'|',linha1);
  fQtReg := StrToIntDef(linha1[1],0);
  if fQtReg=0 then
  begin
    Erros.Add('Nenhum registro para importar.');
    exit;
  end;
  fQtImp := 0;
  for i := 1 to Pred(conteudoArquivo.Count) do
  begin
    linha1.Clear;
    StringToArray( conteudoArquivo[i],'|',linha1);

    if linha1[0]='A' then
    begin
      if Assigned(produto) then
      begin
        Produtos.Add(produto);
        inc(fQtImp);
      end;
      Continue;
    end
    else if ( linha1[0]='I') or ( linha1[0]='M') or ( linha1[0]='O') or ( linha1[0]='N')  then
    begin
      if ( linha1[0]='I') then
      begin
        if linha1.Count<13 then
        begin
          Erros.Add('Linha inválida.('+IntToStr(i)+')');
          Continue;
        end;
        produto := TProdutoModel.create;
        produto.fcProd    := linha1[1];
        produto.fxProd    := linha1[2];
        produto.fcEAN     := linha1[3];
        produto.fNCM      := linha1[4];
        produto.fEXTIPI   := linha1[5];
        produto.fGenero   := linha1[6];
        produto.fuCom     := linha1[7];
        produto.fvUnCom   := StrToFloatDef(linha1[8],0);
        produto.fcEANTrib := linha1[9];
        produto.fuTrib    := linha1[10];
        produto.fvUnTrib  := StrToFloatDef( ReplaceStr(linha1[11],'.',','),0);
        produto.fqTrib    := StrToFloatDef( ReplaceStr(linha1[12],'.',','),0);
      end
      else if (linha1[0]='M') then
      begin
        if linha1.Count<3 then
        begin
          Erros.Add('Linha inválida.('+IntToStr(i)+')');
          Continue;
        end;
        produto.fmIpi  := linha1[1];
        produto.fqtdeN := StrToIntDef(linha1[2],0);
      end
      else if (linha1[0]='O') then
      begin
        if produto.fmIpi='1' then
        begin
          if linha1.Count<4 then
          begin
            Erros.Add('Linha inválida.('+IntToStr(i)+')');
            Continue;
          end;
          produto.fclEnq    := linha1[1];
          produto.fCNPJProd := linha1[2];
          produto.fcEnq     := linha1[3];
        end;
      end
      else if (linha1[0]='N') then
      begin
        if linha1.Count<9 then
        begin
          Erros.Add('Linha inválida.('+IntToStr(i)+')');
          Continue;
        end;
        icms := TICMS.Create;
        icms.fCST      := linha1[1];
        icms.forig     := linha1[2];
        icms.fmodBC    := linha1[3];
        icms.fpICMS    := StrToDateDef( ReplaceStr(linha1[4],'.',','),0);
        icms.fpRedBC   := StrToDateDef( ReplaceStr(linha1[5],'.',','),0);
        icms.fmodBCST  := StrToDateDef( ReplaceStr(linha1[6],'.',','),0);
        icms.fpRedBCST := StrToDateDef( ReplaceStr(linha1[7],'.',','),0);
        icms.fpMVAST   := StrToDateDef( ReplaceStr(linha1[8],'.',','),0);
        produto.fICMS.Add(icms);
      end;
    end;
  end;
end;

procedure TImportaProduto.StringToArray(St: string; Separador: char;
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

end.
