package com.aymax.forum.service.implementations;

import com.aymax.forum.dto.CommentDto;
import com.aymax.forum.dto.PostDto;
import com.aymax.forum.entity.*;
import com.aymax.forum.repository.CommentRepository;
import com.aymax.forum.repository.LikeCommentRepository;
import com.aymax.forum.repository.PostRepository;
import com.aymax.forum.repository.UserRepository;
import com.aymax.forum.security.service.UserDetailsImpl;
import com.aymax.forum.service.interfaces.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.TimeUnit;

@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentRepository commentRepository;
    @Autowired
    private PostRepository postRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private LikeCommentRepository likeCommentRepository;

    @Override
    public Comment createComment(Comment comment) {
        UserDetailsImpl userDetails = (UserDetailsImpl) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        long id = userDetails.getId();
        User u = this.userRepository.findById(id).get();
        comment.setComment_owner(u);
        comment.setDateofpublication(new Date());
        if(comment.getBelong_post() != null && comment.getComment_owner() != null) {
            return this.commentRepository.save(comment);
        }
        throw new NullPointerException("le post fournit est null");
    }

    @Override
    public Comment updateComment(CommentDto commentdto) {
        Comment comment = this.commentRepository.getOne(commentdto.getId());
        UserDetailsImpl userDetails = (UserDetailsImpl) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        long id = userDetails.getId();
        User u = this.userRepository.findById(id).get();
        comment.setComment_owner(u);
        if(comment.getBelong_post() != null && comment.getComment_owner() != null){
            Optional<Comment> c = this.commentRepository.findById(comment.getId());
            Comment updatedComment = c.get();
            updatedComment.setComment_owner(comment.getComment_owner());
            updatedComment.setAttachement(comment.getAttachement());
            updatedComment.setComment_text(comment.getComment_text());
            updatedComment.setBelong_post(comment.getBelong_post());
            updatedComment.setDateofpublication(comment.getDateofpublication());
            return this.commentRepository.save(updatedComment);
        }
        throw new NullPointerException("le post fournit est null");
    }

    @Override
    public Comment getById(long id) {
        if(this.commentRepository.findById(id).isPresent()){
            return this.commentRepository.findById(id).get();
        }
        throw new NullPointerException("comment not found");
    }

    @Override
    public List<Comment> getCommentsOfPost(long post_id) {
        Optional<Post> p = this.postRepository.findById(post_id);
        return this.commentRepository.findByBelong_post(p.get());
    }

    @Override
    public List<Comment> getUserCommentsOfPost(long post_id, long user_id) {
        Optional<Post> p = this.postRepository.findById(post_id);
        Optional<User> u = this.userRepository.findById(user_id);
        return this.commentRepository.findByBelong_postAndComment_owner(p.get(),u.get());
    }

    @Override
    public void deleteComment(Long id) throws Exception {
        UserDetailsImpl userDetails = (UserDetailsImpl) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        long id_user = userDetails.getId();
        LikeCommentPk lk = new LikeCommentPk();
        lk.setComment_id(id);
        lk.setUser_id(id_user);
        try {
            this.likeCommentRepository.deleteByLikeCommentPk(lk);
            this.commentRepository.deleteById(id);
        }
        catch (Exception e){
            throw new Exception("comment with id = " + id + " not found. ");
        }
    }

    @Override
    public User getUserbyCommentId(long id) {

        return this.commentRepository.findById(id).get().getComment_owner();
    }

    @Override
    public int countCommentsByUser(long idUser) {
        return this.commentRepository.countCommentsByUser(idUser);
    }

    @Override
    public List<CommentDto> getListDateDiffofComment(List<CommentDto> p) {
        for (CommentDto c : p) {
            c.setLikes(likeCommentRepository.countCommentLikesByComment(c.getId()));
            c.setDateSinceCommented(getDateDiffofComment(c.getId()));
        }
        return p;
    }

    @Override
    public String getDateDiffofComment(Long idComment) {
        Comment c = commentRepository.getOne(idComment);
        if(c.getDateofpublication() == null) {
            return "";
        }
        long diff = new Date().getTime() - c.getDateofpublication().getTime();
        long diffMinutes = TimeUnit.MILLISECONDS.toMinutes(diff);
        if(diffMinutes > 60){
            long diffHours = TimeUnit.MILLISECONDS.toHours(diff);
            if(diffHours > 24 ){
                long diffDays = TimeUnit.MILLISECONDS.toDays(diff);
                if(diffDays > 6){
                    return c.getDateofpublication().toString();
                }
                return "posted "+diffDays+" days ago.";
            }
            else{
                return "posted "+diffHours+" hours ago.";
            }
        }
        else{
            return "posted "+diffMinutes+" minutes ago.";
        }
    }
}
