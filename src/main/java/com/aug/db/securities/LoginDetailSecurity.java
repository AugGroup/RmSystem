package com.aug.db.securities;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import com.aug.db.entities.Login;

public class LoginDetailSecurity implements LoginDetail{
	
	public static final GrantedAuthority ADMIN_ROLE = new SimpleGrantedAuthority("ADMIN");
	private Login login;
	private Set<GrantedAuthority> grants;

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		if (grants == null) {
            grants = new HashSet<GrantedAuthority>();
            if(login.getUserName().equals("admin")){
            	grants.add(ADMIN_ROLE);
            }
        }
		return grants;
	}

	@Override
	public String getPassword() {
		return login.getPassword();
	}

	@Override
	public String getUserName() {
		return login.getUserName();
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}

}
