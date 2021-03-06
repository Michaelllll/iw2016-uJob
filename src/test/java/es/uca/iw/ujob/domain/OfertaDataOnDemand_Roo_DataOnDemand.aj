// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package es.uca.iw.ujob.domain;

import es.uca.iw.ujob.domain.EmpresaDataOnDemand;
import es.uca.iw.ujob.domain.LocalizacionDataOnDemand;
import es.uca.iw.ujob.domain.Oferta;
import es.uca.iw.ujob.domain.OfertaDataOnDemand;
import es.uca.iw.ujob.domain.estadoOferta;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

privileged aspect OfertaDataOnDemand_Roo_DataOnDemand {
    
    declare @type: OfertaDataOnDemand: @Component;
    
    private Random OfertaDataOnDemand.rnd = new SecureRandom();
    
    private List<Oferta> OfertaDataOnDemand.data;
    
    @Autowired
    EmpresaDataOnDemand OfertaDataOnDemand.empresaDataOnDemand;
    
    @Autowired
    LocalizacionDataOnDemand OfertaDataOnDemand.localizacionDataOnDemand;
    
    public Oferta OfertaDataOnDemand.getNewTransientOferta(int index) {
        Oferta obj = new Oferta();
        setEstado(obj, index);
        setFecha_caducidad(obj, index);
        setFecha_inicio(obj, index);
        setN_vacantes(obj, index);
        setPerfil(obj, index);
        setPuesto(obj, index);
        setSueldo(obj, index);
        setTipo_contrato(obj, index);
        return obj;
    }
    
    public void OfertaDataOnDemand.setEstado(Oferta obj, int index) {
        estadoOferta estado = estadoOferta.class.getEnumConstants()[0];
        obj.setEstado(estado);
    }
    
    public void OfertaDataOnDemand.setFecha_caducidad(Oferta obj, int index) {
        Date fecha_caducidad = new GregorianCalendar(Calendar.getInstance().get(Calendar.YEAR), Calendar.getInstance().get(Calendar.MONTH), Calendar.getInstance().get(Calendar.DAY_OF_MONTH), Calendar.getInstance().get(Calendar.HOUR_OF_DAY), Calendar.getInstance().get(Calendar.MINUTE), Calendar.getInstance().get(Calendar.SECOND) + new Double(Math.random() * 1000).intValue()).getTime();
        obj.setFecha_caducidad(fecha_caducidad);
    }
    
    public void OfertaDataOnDemand.setFecha_inicio(Oferta obj, int index) {
        Date fecha_inicio = new GregorianCalendar(Calendar.getInstance().get(Calendar.YEAR), Calendar.getInstance().get(Calendar.MONTH), Calendar.getInstance().get(Calendar.DAY_OF_MONTH), Calendar.getInstance().get(Calendar.HOUR_OF_DAY), Calendar.getInstance().get(Calendar.MINUTE), Calendar.getInstance().get(Calendar.SECOND) + new Double(Math.random() * 1000).intValue()).getTime();
        obj.setFecha_inicio(fecha_inicio);
    }
    
    public void OfertaDataOnDemand.setN_vacantes(Oferta obj, int index) {
        Integer n_vacantes = new Integer(index);
        obj.setN_vacantes(n_vacantes);
    }
    
    public void OfertaDataOnDemand.setPerfil(Oferta obj, int index) {
        String perfil = "perfil_" + index;
        if (perfil.length() > 255) {
            perfil = perfil.substring(0, 255);
        }
        obj.setPerfil(perfil);
    }
    
    public void OfertaDataOnDemand.setPuesto(Oferta obj, int index) {
        String puesto = "puesto_" + index;
        if (puesto.length() > 255) {
            puesto = puesto.substring(0, 255);
        }
        obj.setPuesto(puesto);
    }
    
    public void OfertaDataOnDemand.setSueldo(Oferta obj, int index) {
        Float sueldo = new Integer(index).floatValue();
        obj.setSueldo(sueldo);
    }
    
    public void OfertaDataOnDemand.setTipo_contrato(Oferta obj, int index) {
        String tipo_contrato = "tipo_contrato_" + index;
        if (tipo_contrato.length() > 50) {
            tipo_contrato = tipo_contrato.substring(0, 50);
        }
        obj.setTipo_contrato(tipo_contrato);
    }
    
    public Oferta OfertaDataOnDemand.getSpecificOferta(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        Oferta obj = data.get(index);
        Integer id = obj.getId();
        return Oferta.findOferta(id);
    }
    
    public Oferta OfertaDataOnDemand.getRandomOferta() {
        init();
        Oferta obj = data.get(rnd.nextInt(data.size()));
        Integer id = obj.getId();
        return Oferta.findOferta(id);
    }
    
    public boolean OfertaDataOnDemand.modifyOferta(Oferta obj) {
        return false;
    }
    
    public void OfertaDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = Oferta.findOfertaEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'Oferta' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<Oferta>();
        for (int i = 0; i < 10; i++) {
            Oferta obj = getNewTransientOferta(i);
            try {
                obj.persist();
            } catch (final ConstraintViolationException e) {
                final StringBuilder msg = new StringBuilder();
                for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                    final ConstraintViolation<?> cv = iter.next();
                    msg.append("[").append(cv.getRootBean().getClass().getName()).append(".").append(cv.getPropertyPath()).append(": ").append(cv.getMessage()).append(" (invalid value = ").append(cv.getInvalidValue()).append(")").append("]");
                }
                throw new IllegalStateException(msg.toString(), e);
            }
            obj.flush();
            data.add(obj);
        }
    }
    
}
