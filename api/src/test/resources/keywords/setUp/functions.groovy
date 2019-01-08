import org.apache.jmeter.engine.util.CompoundVariable
import java.net.URLEncoder

def createAuthorization(String user, String pass) {
    // return an encoded string of user credentials
    if (user.length() > 0) {
        auth = (user + ":" + pass).bytes.encodeBase64().toString()
        return "Basic " + auth
    }
}

def evalVariable(String var) {
    // return an string with result of evaluation
    if (var != null && var.contains("{")) {
        CompoundVariable compoundVar = new CompoundVariable(var)
        return compoundVar.execute()
    }
    return var
}

def encodeVariable(String var) {
    // return an string encoded
    String str = java.net.URLEncoder.encode(var, "UTF-8")
    return str.replaceAll("\\+", "%20")
}

def writeVariablesResponseMessage(List lst) {
    def responseMessage = ""
    lst.each{ it -> responseMessage += "vars.get($it) = " + vars.get(it).toString() + "\n"}
    SampleResult.setResponseData(responseMessage, "UTF-8")
}
