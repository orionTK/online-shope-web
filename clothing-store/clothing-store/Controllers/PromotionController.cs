using Microsoft.AspNetCore.Mvc;

namespace clothing_store.Promotion
{
    using BLL;
    using clothing_store.DAL.Models;
    using Common.Req;
    using Common.Rsp;

    [Route("api/[controller]")]
    [ApiController]
    public class PromotionController : ControllerBase
    {
        public PromotionController()
        {
            _svc = new PromotionSvc();
        }

        [HttpPost("get-by-id")]
        public IActionResult getPromotionId([FromBody] SimpleReq rep)
        {
            var res = new SingleRsp();
            res = _svc.Read(rep.Id);
            return Ok(res);
        }

        [HttpPost("get-by-all")]
        public IActionResult GetAll()
        {
            var res = new SingleRsp();
            var pro = _svc.GetAll();
            res.Data = pro;
            return Ok(res);
        }

        [HttpPost("create-promotion")]
        public IActionResult CreatePromotion([FromBody] PromotionReq req)
        {
            var res = _svc.CreatePromotion(req);

            return Ok(res);
        }

        // Edit
        [HttpPost("update-promotion")]
        public IActionResult UpdatePromotion([FromBody] PromotionReq req)
        {
            var res = _svc.UpdatePromotion(req);

            return Ok(res);
        }

        [HttpPost("delete-promotion")]
        public IActionResult DeletePromotion(Promotion req)
        {
            var res = _svc.DeletePromotion(req);

            return Ok(res);
        }


        [HttpPost("search-promotion")]
        public IActionResult SearchPromotion([FromBody] SearchPromotionReq req)
        {
            var res = new SingleRsp();
            var pro = _svc.SearchPromotion(req.Keyword, req.Page, req.Size);
            res.Data = pro;
            return Ok(res);
        }

        private readonly PromotionSvc _svc;
    }
}