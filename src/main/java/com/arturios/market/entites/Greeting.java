package com.arturios.market.entites;

public class Greeting {

    private String content;
    private int key;

    public Greeting(String content, int key) {
        this.content = content;
        this.key = key;
    }

    public String getContent() {
        return content;
    }

    public int getKey() {
        return key;
    }

    public void setKey(int key) {
        this.key = this.key+ key;
    }
}