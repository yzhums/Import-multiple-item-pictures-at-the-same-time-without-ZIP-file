pageextension 50112 ItemListExt extends "Item List"
{
    actions
    {
        addafter(CopyItem)
        {
            fileuploadaction(ImportMultipleItemPictures)
            {
                ApplicationArea = All;
                Caption = 'Import Multiple Item Pictures';
                Image = Import;
                AllowMultipleFiles = true;

                trigger OnAction(files: List of [FileUpload])
                var
                    CurrentFile: FileUpload;
                    InStr: InStream;
                    FileName: Text;
                    FileMgt: Codeunit "File Management";
                    Item: Record Item;
                begin
                    FileName := '';
                    foreach CurrentFile in Files do begin
                        CurrentFile.CreateInStream(InStr, TextEncoding::MSDos);
                        FileName := FileMgt.GetFileNameWithoutExtension(CurrentFile.FileName);
                        if Item.Get(FileName) then begin
                            Clear(Item.Picture);
                            Item.Picture.ImportStream(InStr, 'Demo picture for item ' + Format(Item."No."));
                            Item.Modify(true);
                        end;
                    end;
                end;
            }
        }
        addafter(CopyItem_Promoted)
        {
            actionref(ImportMultipleItemPictures_Promoted; ImportMultipleItemPictures)
            {
            }
        }
    }
}
