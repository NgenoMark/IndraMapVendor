package com.example.backend.api.model.repositories;

<<<<<<< HEAD
=======
import com.example.backend.api.dto.PaymentDetailResponse;
>>>>>>> be5aac4f9338c3257b2097a477aaec7b13faaca5
import com.example.backend.api.model.PaymentDetail;
import com.example.backend.api.model.PaymentDetailId;
import org.springframework.data.jpa.repository.JpaRepository;

<<<<<<< HEAD
public interface PaymentDetailRepository extends JpaRepository<PaymentDetail, PaymentDetailId> {

=======
import javax.persistence.Embeddable;
import java.util.Optional;

@Embeddable

public interface PaymentDetailRepository extends JpaRepository<PaymentDetail, PaymentDetailId> {

   Optional<PaymentDetail> findById_MapNo(String mapNo);

>>>>>>> be5aac4f9338c3257b2097a477aaec7b13faaca5

}
