// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package es.uca.iw.ujob.domain;

import es.uca.iw.ujob.domain.Empresa;
import es.uca.iw.ujob.domain.EmpresaDataOnDemand;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.stereotype.Component;

privileged aspect EmpresaDataOnDemand_Roo_DataOnDemand {
    
    declare @type: EmpresaDataOnDemand: @Component;
    
    private Random EmpresaDataOnDemand.rnd = new SecureRandom();
    
    private List<Empresa> EmpresaDataOnDemand.data;
    
    public Empresa EmpresaDataOnDemand.getNewTransientEmpresa(int index) {
        Empresa obj = new Empresa();
        setEmail(obj, index);
        setN_empleados(obj, index);
        setNombre(obj, index);
        setOtros(obj, index);
        return obj;
    }
    
    public void EmpresaDataOnDemand.setEmail(Empresa obj, int index) {
        String email = "foo" + index + "@bar.com";
        if (email.length() > 255) {
            email = email.substring(0, 255);
        }
        obj.setEmail(email);
    }
    
    public void EmpresaDataOnDemand.setN_empleados(Empresa obj, int index) {
        Integer n_empleados = new Integer(index);
        obj.setN_empleados(n_empleados);
    }
    
    public void EmpresaDataOnDemand.setNombre(Empresa obj, int index) {
        String nombre = "nombre_" + index;
        if (nombre.length() > 255) {
            nombre = new Random().nextInt(10) + nombre.substring(1, 255);
        }
        obj.setNombre(nombre);
    }
    
    public void EmpresaDataOnDemand.setOtros(Empresa obj, int index) {
        String otros = "otros_" + index;
        obj.setOtros(otros);
    }
    
    public Empresa EmpresaDataOnDemand.getSpecificEmpresa(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        Empresa obj = data.get(index);
        String id = obj.getCif();
        return Empresa.findEmpresa(id);
    }
    
    public Empresa EmpresaDataOnDemand.getRandomEmpresa() {
        init();
        Empresa obj = data.get(rnd.nextInt(data.size()));
        String id = obj.getCif();
        return Empresa.findEmpresa(id);
    }
    
    public boolean EmpresaDataOnDemand.modifyEmpresa(Empresa obj) {
        return false;
    }
    
    public void EmpresaDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = Empresa.findEmpresaEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'Empresa' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<Empresa>();
        for (int i = 0; i < 10; i++) {
            Empresa obj = getNewTransientEmpresa(i);
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
