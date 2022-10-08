package hibernatefundamentosweb.util;

import hibernatefundamentos.pojos.Estudante;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

public class HibernateManager {
 
    private SessionFactory sessionFactory;
    private Session session;
    
    public HibernateManager() {
        this.sessionFactory = HibernateUtil.getSessionFactory();
    }
    
    public boolean save(Estudante estudante) {
        Session session = this.sessionFactory.openSession();
        session.beginTransaction();
        Estudante e = (Estudante) session.get(Estudante.class, estudante.getId());
        if(e != null) {
            return false;
        }
        session.save(estudante);
        session.getTransaction().commit();
        session.close();
        return true;
    }
    
    public Estudante read(int id) {
        this.session = this.sessionFactory.openSession();
        this.session.beginTransaction();
        // Estudante estudante = (Estudante) session.get(Estudante.class, id);
        Query query = this.session.createQuery("from Estudante where id = :id");
        query.setParameter("id", id);        
        Estudante estudante = (Estudante)query.list().get(0);
        this.session.getTransaction().commit();
        return estudante;
    }
    
    public List<Estudante> readAll() {
        Session session = this.sessionFactory.openSession();
        session.beginTransaction();
        List<Estudante> estudante = session.createQuery("from Estudante").list();
        session.getTransaction().commit();
        session.close();        
        return estudante;
    }
    
    public List<Estudante> search(String nome) {
        Session session = this.sessionFactory.openSession();
        session.beginTransaction();
        Query query = session.createQuery("from Estudante where nome like :nome");
        query.setParameter("nome", "%" + nome + "%");
        List<Estudante> estudantes = query.list();
        session.getTransaction().commit();
        session.close();        
        return estudantes;
    }
    
    public void delete(int id) {
        Session session = this.sessionFactory.openSession();
        session.beginTransaction();
        Estudante estudante = new Estudante();
        estudante.setId(id);
        session.delete(estudante);
        session.getTransaction().commit();
        session.close();
    }
    
    public void update(Estudante e) {
        Session session = this.sessionFactory.openSession();
        session.beginTransaction();
        Estudante estudante = (Estudante) session.load(Estudante.class, e.getId());
        estudante.setNome(e.getNome());
        estudante.setCursos(e.getCursos());
        session.update(estudante);
        session.getTransaction().commit();
        session.close();
    }
    
    public long getMax(String nome) {
        Session session = this.sessionFactory.openSession();
        session.beginTransaction();
        String QUERY;
        Query query;
        if(nome.equals("")) {
            QUERY = "select count(*) from Estudante";
            query = session.createQuery(QUERY);
        }
        else {
            QUERY = "select count(*) from Estudante where nome like :nome";
            query = session.createQuery(QUERY);
            query.setParameter("nome", "%" + nome + "%");
        }
        
        Long count = (Long)query.uniqueResult();
        return count;
    }
    
    public void closeSession() {
        if(this.session != null) {
            this.session.close();
        }
    }
    
}