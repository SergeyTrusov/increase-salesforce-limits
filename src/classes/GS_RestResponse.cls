public class GS_RestResponse {

    public Integer code {get; set;}
    public String message {get; set;}
    public String result {get; set;}

    public GS_RestResponse(Integer code, String message, String result) {
        this.code = code;
        this.message = message;
        this.result = result;
    }

    public GS_RestResponse(Integer code, String message) {
        this.code = code;
        this.message = message;
        this.result = null;
    }

    public String toJSON() {
        return JSON.serialize(this);
    }
}