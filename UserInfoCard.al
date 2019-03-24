page 50104 "User Information Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    //Caption = "UserInformationCard";


    layout
    {
        area(Content)
        {
            group(General)
            {
                //Caption = "General";
                field(Id; Id)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        GetUserInfo();
                    end;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field(Email; Email)
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field(Phone; Phone)
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field(CompanyName; CompanyName)
                {
                    ApplicationArea = All;
                    Editable = false;

                }
            }
        }
    }
    var
        Id: Integer;
        Name: Text;
        Email: Text;
        Phone: Text;
        CompanyName: Text;

    local procedure GetUserInfo()
    var

        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
        Token: JsonToken;
        Object: JsonObject;
        JsonText: Text;
        Url: Text;

    begin
        Url := 'https://jsonplaceholder.typicode.com/users/' + Format(Id);
        if not client.Get(Url, responseMessage) then
            Error('The call to the web service failed.');
        if not ResponseMessage.IsSuccessStatusCode then
            Error('The web service returned an error message:\\' +
                  'Status code: %1\' +
                  'Description: %2',
                  ResponseMessage.HttpStatusCode,
                  ResponseMessage.ReasonPhrase);
        ResponseMessage.Content.ReadAs(JsonText);

        if not Object.ReadFrom(JsonText) then
            Error('Invalid response, expected a JSON object');

        Object.Get('name', Token);
        Name := Token.AsValue().AsText();
        Object.Get('phone', Token);
        Phone := Token.AsValue().AsText();
        Object.Get('email', Token);
        Email := Token.AsValue().AsText();
        Object.Get('company', Token);
        Token.AsObject.Get('name', Token);
        CompanyName := Token.AsValue().AsText();


    end;


}





