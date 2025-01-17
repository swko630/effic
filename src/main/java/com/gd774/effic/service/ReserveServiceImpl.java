package com.gd774.effic.service;

import java.util.HashMap;
import java.util.List;
import java.util.Locale.Category;
import java.util.Map;
import java.util.Optional;

import org.springframework.core.io.AbstractFileResolvingResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.gd774.effic.dto.CategoryDto;
import com.gd774.effic.dto.FacilityManageDto;
import com.gd774.effic.dto.FacilityReserveDto;
import com.gd774.effic.dto.UserDto;
import com.gd774.effic.mapper.ReserveMapper;
import com.gd774.effic.util.PageUtils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.xml.ws.Response;

@Transactional
@Service
public class ReserveServiceImpl implements ReserveService {

  private final ReserveMapper reserveMapper;
  private final PageUtils pageUtils;
  
  public ReserveServiceImpl(ReserveMapper reserveMapper, PageUtils pageUtils) {
    super();
    this.reserveMapper = reserveMapper;
    this.pageUtils = pageUtils;
  }

  // 자산 등록
  @Override
  public int registerFacility(HttpServletRequest request) {
    System.out.println("catCode:" + request.getParameter("catCode"));
    String modelName = request.getParameter("modelName");
    String buyDt = request.getParameter("buyDt");
    System.out.println("이건 상태"+Integer.parseInt(request.getParameter("facilityState")));
    System.out.println("이건대여"+Integer.parseInt(request.getParameter("rentTerm")));

    
    try {
      int facilityState = Integer.parseInt(request.getParameter("facilityState"));
      int rentTerm = Integer.parseInt(request.getParameter("rentTerm"));
      String catType = request.getParameter("catType");
      String catCode = request.getParameter("catCode");

      CategoryDto cat = new CategoryDto();
      cat.setCatCode(catCode);

      FacilityManageDto facilityMng = FacilityManageDto.builder()
          .facilityState(facilityState)
          .modelName(modelName)
          .buyDt(buyDt)
          .rentTerm(rentTerm)
          .cat(cat)
          .build();
      
      int insertCount = reserveMapper.insertFacility(facilityMng);
      
      return insertCount;
      
     
    } catch (Exception e) {
      e.printStackTrace();
    }
    
    
    return 0;
    
  }
  
  // 자산 리스트 가져오기
  @Override
  public ResponseEntity<Map<String, Object>> getFacilityList(HttpServletRequest request) {
    
    try {
      int total = reserveMapper.getFacilityCount();
      int display = 10;
      int page = Integer.parseInt(request.getParameter("page"));
      pageUtils.setPaging(total, display, page);
      Map<String, Object> map = Map.of("begin", pageUtils.getBegin()
                                     , "end", pageUtils.getEnd());
      return new ResponseEntity<>(Map.of("getFacilityList", reserveMapper.getFacilityList(map)
                                , "totalPage", pageUtils.getTotalPage())
                                ,  HttpStatus.OK);
    } catch (Exception e) {
      e.printStackTrace();
    }
    
    return null;

  }

  // 카테고리 가져오기
  @Override
  public void loadCategoryList(Model model) {
  List<CategoryDto> mCatList = reserveMapper.getMCategoryList();
  Map<String, List<CategoryDto>> map = new HashMap<>();
  for(CategoryDto c : mCatList) {
      map.put(c.getCatCode(),reserveMapper.getSCategoryList(c.getCatCode()));
  }
  model.addAttribute("mCatList", mCatList);
  model.addAttribute("map", map);
  }
  
  // 자산 Id 가져오기
  @Override
  public FacilityManageDto getFacilityById(int facilityId) {
    System.out.println(reserveMapper.getFacilityById(facilityId));
    return reserveMapper.getFacilityById(facilityId);
  }
  
  // 자산 수정 리스트 가져오기
  @Override
  public int modifyFacilityList(HttpServletRequest request) {
    try {
      int facilityId = Integer.parseInt(request.getParameter("facilityId"));
      int facilityState = Integer.parseInt(request.getParameter("facilityState"));
      int rentTerm = Integer.parseInt(request.getParameter("rentTerm"));
      FacilityManageDto facility = FacilityManageDto.builder()
          .facilityId(facilityId)
          .facilityState(facilityState)
          .rentTerm(rentTerm)
          .build();
      
      int modifyResult = reserveMapper.updateFacilityList(facility);
      return modifyResult;
            
    } catch (Exception e) {
      return 0;
    }
      
  }
  
  @Override
  public int removeFacility(int facilityId) {
    return reserveMapper.deleteFacilityList(facilityId);
  }
  
  
  // 자산 예약 화면에 리스트 가져오기
  @Override
  public ResponseEntity<Map<String, Object>> getFacReserveList(HttpServletRequest request) {
  
    int total = reserveMapper.getFacilityCount();
    int display = 10;
    int page = Integer.parseInt(request.getParameter("page"));
    pageUtils.setPaging(total, display, page);
    Map<String, Object> map = Map.of("begin", pageUtils.getBegin()
                                   , "end", pageUtils.getEnd());
    System.out.println(reserveMapper.getFacReserveList(map));
    
    return new ResponseEntity<>(Map.of("getFacReserveList", reserveMapper.getFacReserveList(map)
                                      ,"totalPage", pageUtils.getTotalPage())
                                      , HttpStatus.OK);
  }
  @Override
  public int FacilityReserve(HttpServletRequest request) {
    int facilityId = Integer.parseInt(request.getParameter("facilityId"));
    String startDt = request.getParameter("startDt");
    String endDt = request.getParameter("endDt");
    System.out.println(facilityId);
    System.out.println(startDt);
    System.out.println(endDt);
    FacilityReserveDto facReserve = FacilityReserveDto.builder()
                                          .facilityId(facilityId)
                                          .startDt(startDt)
                                          .endDt(endDt)
                                          .build();
    int reserveResult = reserveMapper.updateFacReserve(facReserve);
    return reserveResult;
  }

  @Override
  public ResponseEntity<Map<String, Object>> getFacilityReseve(HttpServletRequest request) {
    int total = reserveMapper.getFacReserveCount();
    int display = 3;
    int page = Integer.parseInt(request.getParameter("page"));
    pageUtils.setPaging(total, display, page);
    Map<String, Object> map = Map.of("beging", pageUtils.getBegin()
                                    ,"end", pageUtils.getEnd());
    return new ResponseEntity<>(Map.of("getFacReserve", reserveMapper.getFacReserve(map)
                                      ,"totalPage", pageUtils.getTotalPage())
                                      , HttpStatus.OK);
   }


}