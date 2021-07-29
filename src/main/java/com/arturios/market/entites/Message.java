package com.arturios.market.entites;

public class Message {
    private String name;
    private int key;

    public String getName() {
        return name;
    }

    public int getKey() {
        return key;
    }

    public void setKey(int key) {
        this.key = this.key + key;
        System.out.println("WWWWW "+this.key);
    }
}
