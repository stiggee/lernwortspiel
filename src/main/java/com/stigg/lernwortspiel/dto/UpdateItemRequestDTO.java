package com.stigg.lernwortspiel.dto;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class UpdateItemRequestDTO {
    private String itemID;
    private String itemTitle;
}