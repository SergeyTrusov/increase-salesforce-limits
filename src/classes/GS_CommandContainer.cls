public class GS_CommandContainer {

    public abstract class GS_Command {

        private Map<String, String> params = new Map<String, String>();

        public void setParams(Map<String, String> params) {
            this.params = params;
        }

        public GS_RestResponse execute() {
            try {
                return new GS_RestResponse(GS_StatusCode.OK, getMessage(), getResultJson());
            } catch (GS_Exception exp) {
                String message = exp.getMessage() + exp.getStackTraceString();
                return new GS_RestResponse(GS_StatusCode.ERROR, message);
            } catch (Exception exp) {
                String message =  exp.getMessage() + exp.getStackTraceString();
                return new GS_RestResponse(GS_StatusCode.ERROR, message);
            }
        }

        public abstract Object perform();

        public String getResultJson() {
            return JSON.serialize(perform());
        }

        public virtual String getMessage() {
            return null; 
        }
    }

    public class GS_100QueryTestCommand extends GS_Command {

        public override Object perform() {
            for (Integer i = 0; i < Limits.getLimitQueries(); i++) {
                List<Account> accountList = [
                    SELECT Id, AccountNumber, AccountSource
                    FROM Account
                ];
            }
            return new Map<String, Integer>{
                'getLimitQueries' => Limits.getLimitQueries(),
                'getQueries' => Limits.getQueries()
            };
        }

        public override String getMessage() {
            return '100 SOQL queries';
        }
    }

    public class GS_DefaultCommand extends GS_Command {

        public override Object perform() {
            return 'This is defult result.';
        }

        public override String getMessage() {
            return 'This is default message.';
        }
    }
}