public class GS_Executor {

    public static Object execute(String commandName, Map<String, String> commandParam, Type returnType) {
        try {
            PageReference restApiPage = Page.GS_RestApi;
            restApiPage.getParameters().put(GS_RestApiController.COMMAND_NAME_PARAM, commandName);
            if (commandParam != null) {
                for (String paramName : commandParam.keySet()) {
                    restApiPage.getParameters().put(paramName, commandParam.get(paramName));
                }
            }
            Blob blobResult = restApiPage.getContent();
            String stringResult = blobResult.toString();
            GS_RestResponse response = (GS_RestResponse)JSON.deserialize(stringResult, GS_RestResponse.class);
            if (response.code == GS_StatusCode.OK) {
                if (returnType != null) {
                    return JSON.deserialize(response.result, returnType);
                } else {
                    return response.result;
                }
            } else if (response.code == GS_StatusCode.ERROR) {
                throw new GS_Exception(response.message);
            }
            return null;
        } catch (GS_Exception gsException) {
            throw gsException;
        } catch (Exception exp) {
            throw new GS_Exception(exp.getMessage());
        }
    }
}