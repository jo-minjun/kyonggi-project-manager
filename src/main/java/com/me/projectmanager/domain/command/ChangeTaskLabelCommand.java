package com.me.projectmanager.domain.command;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ChangeTaskLabelCommand {

  private String label;
}
