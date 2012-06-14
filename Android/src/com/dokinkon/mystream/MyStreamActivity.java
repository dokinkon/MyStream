package com.dokinkon.mystream;

import java.io.IOException;

import android.app.Activity;
import javax.jmdns.JmDNS;
import javax.jmdns.ServiceInfo;

import android.os.Bundle;

public class MyStreamActivity extends Activity {
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        setUp();
    }
    
    @Override
    protected void onStop() {
    	if (jmdns != null) {
	        jmdns.unregisterAllServices();
	        try {
	            jmdns.close();
	        } catch (IOException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }
	        jmdns = null;
		}
	    lock.release();
		super.onStop();
	}
    
    
    private android.net.wifi.WifiManager.MulticastLock lock;
    private JmDNS jmdns = null;
    private ServiceInfo serviceInfo;
    
    private void setUp() {
        android.net.wifi.WifiManager wifi = (android.net.wifi.WifiManager) getSystemService(android.content.Context.WIFI_SERVICE);
        lock = wifi.createMulticastLock("mylockthereturn");
        lock.setReferenceCounted(true);
        lock.acquire();
        try {
            jmdns = JmDNS.create();
            serviceInfo = ServiceInfo.create("_mystream._tcp.local.", "AndroidTest", 0, "plain test service from android");
            jmdns.registerService(serviceInfo);
        } catch (IOException e) {
            e.printStackTrace();
            return;
        }
    }

}