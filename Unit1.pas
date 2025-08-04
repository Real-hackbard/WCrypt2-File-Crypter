unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, wcrypt2, StdCtrls, ComCtrls, ExtCtrls, Spin, XPMan;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    StatusBar1: TStatusBar;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button3: TButton;
    Button4: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Button5: TButton;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
function RandomWord(dictSize, lngStepSize, wordLen, minWordLen: Integer): string;
begin
  Result := '';
  if (wordLen < minWordLen) and (minWordLen > 0) then
    wordLen := minWordLen
  else if (wordLen < 1) and (minWordLen < 1) then wordLen := 1;
  repeat
    Result := Result + Chr(Random(dictSize) + lngStepSize);
  until (Length(Result) = wordLen);
end;

procedure CryptFile(const SourceFileName, DestinationFileName, Password: string; ToCrypt: Boolean);
var
  hProv: HCRYPTPROV;
  hash: HCRYPTHASH;
  key: HCRYPTKEY;

  Buffer: PByte;
  len: dWord;
  fsIn, fsOut: TFileStream;
  IsEndOfFile: Boolean;
begin
  {get context for crypt default provider}
  CryptAcquireContext(@hProv, nil, nil, PROV_RSA_FULL, CRYPT_VERIFYCONTEXT);
  {create hash-object (SHA algorithm)}
  CryptCreateHash(hProv, CALG_SHA, 0, 0, @hash);
  {get hash from password}
  CryptHashData(hash, @Password[1], Length(Password), 0);
  {create key from hash by RC4 algorithm}
  CryptDeriveKey(hProv, CALG_RC4, hash, 0, @key);
  {destroy hash-object}
  CryptDestroyHash(hash);

  {open source+destination files}
  fsIn := TFileStream.Create(SourceFileName, fmOpenRead or fmShareDenyWrite);
  fsOut := TFileStream.Create(DestinationFileName, fmCreate);
  try
    {allocate buffer to read content from source file}
    GetMem(Buffer, 512);

    repeat
      IsEndOfFile := (fsIn.Position >= fsIn.Size);
      if IsEndOfFile then break;

      {read content from source file}
      len := fsIn.Read(Buffer^, 512);

      if ToCrypt then
        {crypt buffer}
        CryptEncrypt(key, 0, IsEndOfFile, 0, Buffer, @len, len)
      else
        {decrypt buffer}
        CryptDecrypt(key, 0, IsEndOfFile, 0, Buffer, @len);

      {write changed buffer to destination file}
      fsOut.Write(Buffer^, len)
    until IsEndOfFile;

    {release memory allocated for buffer}
    FreeMem(Buffer, 512);
  finally
    fsIn.Free;
    fsOut.Free;
  end;

  {release the context for crypt default provider}
  CryptReleaseContext(hProv, 0);

  MessageDlg('Process finish!',mtInformation, [mbOK], 0);
end;
procedure TForm1.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then Edit1.Text := OpenDialog1.FileName;
  Edit2.Text := OpenDialog1.FileName + '.cry';
  Button4.Enabled := true; Button5.Enabled := false;
  Label3.Caption := 'Source :';
  Label4.Caption := 'Crypt :';
  StatusBar1.SetFocus;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if SaveDialog1.Execute then Edit2.Text := SaveDialog1.FileName;
  Edit1.Text := SaveDialog1.FileName + '.exe';
  Button4.Enabled := false; Button5.Enabled := true;
  Label3.Caption := 'Decrypt :';
  Label4.Caption := 'Source :';
  StatusBar1.SetFocus;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if Edit3.Text = '' then begin ShowMessage('No Key !'); Exit; end;
  CryptFile(Edit1.Text, Edit2.Text, Edit3.Text, True);
  StatusBar1.SetFocus;
  StatusBar1.SimpleText := 'Crypting success..';
  Application.ProcessMessages;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if Edit3.Text = '' then begin ShowMessage('No Key !'); Exit; end;
  CryptFile(Edit2.Text, Edit1.Text, Edit3.Text, False);
  StatusBar1.SetFocus;
  StatusBar1.SimpleText := 'Decrypting success..';
  Application.ProcessMessages;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Edit3.Text := RandomWord(33, 54, Random(SpinEdit1.Value), 2);
  StatusBar1.SetFocus;
  Application.ProcessMessages;
end;

end.
 