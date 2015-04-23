package com.navkr.assist.dto;

public class AjaxObject {
	
	private boolean error = false;
	private Object data = null;
	private Object data1 = null;
	private String errorMessage = "";
	private String errorType;
	private String objectType = null;

	public AjaxObject(){
	}

	
	public boolean isError() {
		return error;
	}
	public void setError(boolean error) {
		this.error = error;
	}
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
		if(data!=null)
		this.objectType=data.getClass().getCanonicalName();
		else this.objectType=null;
	}
	
	public Object getData1() {
		return data1;
	}
	public void setData1(Object data1) {
		this.data1 = data1;
	}
	
    public String getErrorMessage() {
        return errorMessage;
    }
    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

	public String getErrorType() {
		return errorType;
	}

	public void setErrorType(String errorType) {
		this.errorType = errorType;
	}

	public String getObjectType() {
		return objectType;
	}
}