using Microsoft.AspNetCore.Mvc;

namespace clothing_store.Controllers
{
    using BLL;
    using clothing_store.DAL.Models;
    using Common.Req;
    using Common.Rsp;

    [Route("api/[controller]")]
    [ApiController]
    public class ProductsController : ControllerBase
    {
        public ProductsController()
        {
            _svc = new ProductsSvc();
        }

        [HttpPost("get-by-id/{id}")]
        public IActionResult getProductsId(int id)
        {
            var res = new SingleRsp();
            var pro = _svc.getProductsId(id);
            res.Data = pro;
            return Ok(res);
        }

        [HttpPost("get-by-all")]
        public IActionResult getAllProducts([FromBody] SimpleReq rep)
        {
            var res = new SingleRsp();
            res.Data = _svc.All;
            return Ok(res);
        }

        // đưa ra swagger
        [HttpPost("search-product")]
        public IActionResult SearchProduct([FromBody] SearchReq req)
        {
            var res = new SingleRsp();
            var pro = _svc.SearchProduct(req.Keyword, req.Page, req.Size);
            res.Data = pro;
            return Ok(res);
        }

        // Create new
        [HttpPost("create-product")]
        public IActionResult CreateProduct([FromBody] ProductsReq req)
        {
            var res = _svc.CreateProduct(req);

            return Ok(res);
        }

        // Edit
        [HttpPost("update-product")]
        public IActionResult UpdateProduct([FromBody] ProductsReq req)
        {
            var res = _svc.UpdateProduct(req);

            return Ok(res);
        }

        [HttpPost("search-product-by-gender")]
        public IActionResult SearchProductByGender([FromBody] SearchReq req)
        {
            var res = new SingleRsp();
            var pro = _svc.SearchProductByGender(req.Keyword, req.Page, req.Size, req.Gender);
            res.Data = pro;
            return Ok(res);
        }

        [HttpPost("delete-product")]
        public IActionResult DeleteProduct(Products req)
        {
            var res = _svc.DeleteProduct(req);

            return Ok(res);
        }

        [HttpPost("get-all-product-by-gender-linq")]
        public IActionResult GetAllProductByGender_Linq([FromBody]CategoriesReq req)
        {
            var res = new SingleRsp();
            var hist = _svc.GetAllProductByGender_Linq(req.Gender);
            res.Data = hist;
            return Ok(res);
        }

        [HttpPost("get-product-by-categoryName-linq")]
        public IActionResult GetProductByCategoryName_Linq([FromBody]SearchReq req)
        {
            var res = new SingleRsp();
            var hist = _svc.GetProductByCategoryName_Linq(req.Keyword, req.Page, req.Size, req.CategoryName, req.Gender);
            res.Data = hist;
            return Ok(res);
        }

        [HttpPost("get-product-by-promotion-linq")]
        public IActionResult GetProductByPromotion_Linq([FromBody]CategoriesReq req)
        {
            var res = new SingleRsp();
            var hist = _svc.GetProductByPromotion_Linq(req.Gender);
            res.Data = hist;
            return Ok(res);
        }

        // Product-Sale
        [HttpPost("get-product-sale-linq")]
        public IActionResult GetSP_ProductSale([FromBody]ProductsReq req)
        {
            var res = new SingleRsp();
            var hist = _svc.GetSP_ProductSale(req.Keyword, req.Page, req.Size);
            res.Data = hist;
            return Ok(res);
        }

        // Product-Accessories
        [HttpPost("get-product-accessories-linq")]
        public IActionResult GetSP_ProductAccessories([FromBody]ProductsReq req)
        {
            var res = new SingleRsp();
            var hist = _svc.GetSP_ProductAccessories(req.Keyword, req.Page, req.Size);
            res.Data = hist;
            return Ok(res);
        }

        private readonly ProductsSvc _svc;
    }
}