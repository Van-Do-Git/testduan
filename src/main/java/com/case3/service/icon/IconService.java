package com.case3.service.icon;

import com.case3.config.ConnectionJDBC;
import com.case3.model.Icon;
import com.case3.service.IService;

import javax.naming.ldap.PagedResultsControl;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class IconService {
    private static final String FIND_ALL_ICON = "select * from icon;";
    Connection connection = ConnectionJDBC.getConnection();

    public List<Icon> findAll() {
        List<Icon> listIcon = new ArrayList<>();
        try {
            PreparedStatement statement = connection.prepareStatement(FIND_ALL_ICON);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id_icon");
                String link = resultSet.getString("link_icon");
                listIcon.add(new Icon(id, link));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return listIcon;
    }

}
