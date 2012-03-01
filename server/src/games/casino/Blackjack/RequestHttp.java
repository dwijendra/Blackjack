package games.casino.Blackjack;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.*;
import java.io.*;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.stream.StreamSource;
import org.w3c.dom.Document;
import org.xml.sax.EntityResolver;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
//import org.xml.sax.*;
//import org.xml.sax.helpers.*;





public class RequestHttp 
{
	RequestHttp()
	{
		
	}
	public String SendRequest(String url1,String data)
	{
		 String Line1="";
		try {
		   
		    URL url = new URL(url1);
		    HttpURLConnection conn = (HttpURLConnection)url.openConnection();
		    conn.setRequestMethod("POST");

		    conn.setDoOutput(true);
		   // conn.s
		    //setContentType("text/html");
            
		    OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
		    
		    wr.write(data);
		    wr.flush();

		   // StringBuffer sb = new StringBuffer();
		    //Reader reader = new InputStreamReader(in, "UTF-8");
 
		 // the SAX way:
		   // XMLReader myReader = XMLReaderFactory.createXMLReader();
		   // myReader.setContentHandler(handler);
		    //myReader.parse(new InputSource(new URL(url).openStream()));
		    
		    // Get the response
		   //Document xmldoc = readXml(conn.getInputStream());
		   //System.out.println(xmldoc.toString() + " XML");
		    BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
		    String line;
		    //(conn.getContentType())
		    // System.out.print("hi---------------"+conn.setconte+"hi--------------");
		    while ((line = rd.readLine()) != null) {
		    	
                System.out.print("hi"+line);
		    	Line1+=line;
		    }
		    wr.close();
		    rd.close();
		   
		}
		catch (Exception e) {
		}
		 return Line1;

	}
	
	public static Document readXml(InputStream is) throws SAXException, IOException,
    ParserConfigurationException {
    DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();

    dbf.setValidating(false);
    dbf.setIgnoringComments(false);
    dbf.setIgnoringElementContentWhitespace(true);
    dbf.setNamespaceAware(true);
    // dbf.setCoalescing(true);
    // dbf.setExpandEntityReferences(true);

    DocumentBuilder db = null;
    db = dbf.newDocumentBuilder();
    db.setEntityResolver(new NullResolver());

    // db.setErrorHandler( new MyErrorHandler());

    return db.parse(is);
	}

	

}

class NullResolver implements EntityResolver {
	  public InputSource resolveEntity(String publicId, String systemId) throws SAXException,
	      IOException {
	    return new InputSource(new StringReader(""));
	  }
	}
