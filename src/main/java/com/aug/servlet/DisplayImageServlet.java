package com.aug.servlet;
import java.awt.AlphaComposite;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ResourceBundle;
import java.util.regex.Matcher;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;

public class DisplayImageServlet extends HttpServlet {

	private static Logger LOGGER = LoggerFactory.getLogger(DisplayImageServlet.class);
    private static final long serialVersionUID = 8500706756578949263L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public DisplayImageServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!StringUtils.isEmpty(request.getParameter("namespace"))) {
            this.displayImage(request, response);
        } else this.previewImagePath(request, response);
    }

    public void displayImage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ResourceBundle resource = ResourceBundle.getBundle("applicationResources");
        File imageFile = new File(resource.getString("file.path") + request.getParameter("namespace") + "/" + request.getParameter("fileName"));
        FileInputStream fin = new FileInputStream(imageFile);
        ServletOutputStream outStream = response.getOutputStream();
        response.setContentType("image/jpeg");
        int i = 0;
        while (i != -1) {
            i = fin.read();
            outStream.write(i);
        }
        fin.close();
    }

    public void previewImagePath(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = null;
        String size = null;
        String path = null;
        String pathName = null;
        InputStream is = null;
        OutputStream sos = null;
        BufferedImage bufferedImage = null;
        BufferedInputStream bis = null;
        ResourceBundle resource = null;
        byte[] image = null;
        byte[] tempByte = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
        int width = 1000;
        int calcHeight = 0;

        try {
            name = (String) request.getParameter("name");
            size = (String) request.getParameter("size");
            resource = ResourceBundle.getBundle("applicationResources");
            path = changeFileSeparatorForOS(resource.getString("ApplicationAbsolutePath") + resource.getString("UserAttachments"));
            pathName = path + name;

            LOGGER.info(" ----------------- path -------------- :" + pathName);
            if (name != null && !"".equals(name)) {
                File imageFile = new File(pathName);
                if (!imageFile.exists()) {
                    pathName = path + "noPhotoAvailable-resize.jpg";
                    imageFile = new File(pathName);
                }

                image = new byte[16];
                sos = response.getOutputStream();

                if ("mini".equals(size)) {
                    bufferedImage = ImageIO.read(imageFile);
                    calcHeight = (width * bufferedImage.getHeight() / bufferedImage.getWidth());
                    ImageIO.write(createResizedCopy(bufferedImage, width, calcHeight), "JPG", response.getOutputStream());
                } else {
                    is = new FileInputStream(imageFile);
                    bis = new BufferedInputStream(is);
                    int count = 0;
                    while ((count = bis.read(image)) >= 0) {
                        sos.write(image, 0, count);
                    }
                    is.close();
                    bis.close();
                }
            }

        } catch (NullPointerException ex) {
            sos.write(tempByte);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (sos != null) {
                sos.flush();
                sos.close();
            }
            name = null;
            size = null;
            resource = null;
            path = null;
            pathName = null;
            is = null;
            sos = null;
            bufferedImage = null;
            bis = null;
            image = null;
            tempByte = null;
        }
    }

    BufferedImage createResizedCopy(Image originalImage, int scaledWidth, int scaledHeight) {
        BufferedImage scaledBI = new BufferedImage(scaledWidth, scaledHeight, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = scaledBI.createGraphics();
        g.setComposite(AlphaComposite.Src);
        g.drawImage(originalImage, 0, 0, scaledWidth, scaledHeight, null);
        g.dispose();
        return scaledBI;
    }

    private static String changeFileSeparatorForOS(final String pathname) {
        return pathname.replaceAll("(/|\\|/|\\\\)", Matcher.quoteReplacement(File.separator));
    }

}