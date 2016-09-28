program Demo;

uses
  Forms,
  UDemo in 'UDemo.pas' {frmDemo},
  UTXTCliente in 'UTXTCliente.pas',
  UTXTProduto in 'UTXTProduto.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmDemo, frmDemo);
  Application.Run;
end.
