package dao;

import entity.SurplusFood;
import java.util.List;

public interface SurplusFoodDao {
    void addSurplusFood(SurplusFood food);
    void updateSurplusFood(SurplusFood food);
    void updateSurplusQuantity(int id, int quantity);
    void deleteSurplusFood(int foodId);
    SurplusFood getSurplusFoodById(int foodId);
    List<SurplusFood> getAllSurplusFoods();
    List<SurplusFood> getSurplusFoodsForDonation();
    List<SurplusFood> getSurplusFoodsForSale();
    List<SurplusFood> getSurplusFoodByUserID(int userID);
}
