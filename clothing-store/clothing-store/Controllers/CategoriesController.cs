using Microsoft.AspNetCore.Mvc;

namespace clothing_store.Controllers
{
    using BLL;
    using clothing_store.DAL.Models;
    using Common.Req;
    using Common.Rsp;

    [Route("api/[controller]")]
    [ApiController]
    public class CategoriesController : ControllerBase
    {
        public CategoriesController()
        {
            _svc = new CategoriesSvc();
        }        

        [HttpPost("get-by-id")]
        public IActionResult getCategoryById([FromBody]SimpleReq req)
        {
            var res = new SingleRsp();
            res = _svc.Read(req.Id);
            return Ok(res); // 200: OK
        }

        [HttpPost("get-all")]
        public IActionResult getAllCategory()
        {
            var res = new SingleRsp();
            res.Data = _svc.All;
            return Ok(res);
        }

        [HttpPost("create-category")]
        public IActionResult CreateCategory([FromBody] CategoriesReq req)
        {
            var res = _svc.CreateCategory(req);

            return Ok(res);
        }

        [HttpPost("update-category")]
        public IActionResult UpdateCategory([FromBody] CategoriesReq req)
        {
            var res = _svc.UpdateCategory(req);

            return Ok(res);
        }

        [HttpPost("delete-category")]
        public IActionResult DeleteCategory(Categories req)
        {
            var res = _svc.DeleteCategory(req);

            return Ok(res);
        }

        [HttpPost("search-category")]
        public IActionResult SearchCategory([FromBody] SearchReq req)
        {
            var res = new SingleRsp();
            var pro = _svc.SearchCategory(req.Keyword, req.Page, req.Size);
            res.Data = pro;
            return Ok(res);
        }

        [HttpPost("get-categoryname-by-gender-linq")]
        public IActionResult GetCategoryNameByGender_Linq([FromBody] CategoriesReq req)
        { 
            var res = new SingleRsp();
            var pro = _svc.GetCategoryNameByGender_Linq(req.Gender);
            res.Data = pro;
            return Ok(res);
        }

        private readonly CategoriesSvc _svc;
    }
}