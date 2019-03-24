/* page 50130 GetUsers
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    //SourceTable = TableName;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Name; Name)
                {
                    ApplicationArea = All;

                }
            }
        }
    }


    local procedure GetUser(UserNumber: Integer)
    var
        client: HttpClient;
        responseMessage: HttpResponseMessage;
        content: text;
        urlBuilder: TextBuilder;
        token: JsonToken;

    begin
        client.SetBaseAddress('https://jsonplaceholder.typicode.com');
        urlBuilder.Append('users/');
        urlBuilder.Append(Format(UserNumber));
        if not client.get(urlBuilder.ToText(), responseMessage) then
            Error('The call to the web service failed.');

        if not responseMessage.IsSuccessStatusCode() then
            Error('The web service returned an error message ::\\' +
            'status code %1\' +
            'Description :%2',
            responseMessage.HttpStatusCode,
            responseMessage.ReasonPhrase);

        responseMessage.Content().ReadAs(content);

        if not token.ReadFrom(content) then
            Error('Invalid response,expected a JASON object');

        token.AsObject().Get('name', token);

        message(token.AsValue().AsText());
    end;

    local procedure CreatePost()
    var
        myInt: Integer;
        client: HttpClient;
        responseMessage: HttpResponseMessage;
        contnet: HttpContent;
        returnText: Text;
        object: JsonObject;
        objectText: text;
    begin
        object.Add('userId', 2);
        object.Add('id', 101);
        object.Add('title', 'Microsoft Dynamics 365 business central post test');
        object.Add('body', 'this is a Microsoft Dynamics 365 Business Central post test');

        object.WriteTo(objectText);
        contnet.WriteFrom(objectText);

        if not client.Post('https://jsonplaceholder.typicode.com/posts', contnet, responseMessage) then
            Error('The call tothe web service failed');

        if not responseMessage.IsSuccessStatusCode() then
            Error('The web service returned an error message ::\\' +
            'status code %1\' +
            'Description :%2',
            responseMessage.HttpStatusCode,
            responseMessage.ReasonPhrase);
        responseMessage.Content.ReadAs(returnText);
        Message(returnText);

    end;

} */