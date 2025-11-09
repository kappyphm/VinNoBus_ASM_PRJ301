/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package module.ticket.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

/**
 *
 * @author kappyphm
 */
@WebServlet(name="TicketServlet", urlPatterns={
    "/ticket/buy",
    "/ticket/checkin",
    "/ticket/create",
})
public class TicketServlet extends HttpServlet {
   

}
