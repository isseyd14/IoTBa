package entities;

import enums.Role;

public class Staff extends User {
    Role role;

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }
}