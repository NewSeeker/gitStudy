package test;

import java.io.IOException;  
import java.util.Hashtable;

import com.ibm.mq.MQC;
import com.ibm.mq.MQException;  
import com.ibm.mq.MQMessage;  
import com.ibm.mq.MQPutMessageOptions;  
import com.ibm.mq.MQQueue;  
import com.ibm.mq.MQQueueManager;  

/**
 * function : 演示MQ集群的负载平衡效果
 * jars : 1, connector.jar
 *        2, com.ibm.mq.jar 
 * @author **
 */
public class myTest1 {
	private static String qmName = "FULL_QM1";   
	private static String qName = "TEST_QUEUE";
	private static MQQueueManager qMgr;   
	private static Hashtable properties = new Hashtable();  
	  
	public static void main(String args[]) {
		try {
			properties.put("hostname", "192.168.2.85");  
	        properties.put("port", new Integer(5000));  
	        properties.put("channel", "SYSTEM.ADMIN.SVRCONN"); 
	        int openOptions = MQC.MQOO_BIND_AS_Q_DEF + MQC.MQOO_OUTPUT; 
	             
	        qMgr = new MQQueueManager(qmName, properties);      
	        MQQueue remoteQ = qMgr.accessQueue(qName, openOptions);
	        
	        MQMessage putMessage = new MQMessage(); 
	        //putMessage.writeString("test");
	        putMessage.writeString("test");
	        
	        MQPutMessageOptions pmo = new MQPutMessageOptions();  	            
	        remoteQ.put(putMessage, pmo);
	        System.out.println("Message has been input into the Remote Queue");
	        
	        remoteQ.close();   
	        qMgr.disconnect();
	        
		}catch (MQException ex) {
			System.out.println("A WebSphere MQ error occurred : Completion code " + ex.completionCode +   
	          " Reason code " + ex.reasonCode);   
	    }catch (IOException ex) {   
	        System.out.println("An error occurred whilst writing to the message buffer: " + ex);   
	    }catch(Exception ex){  
	        ex.printStackTrace();  
	    }
	}  
}
	 
	      
