using Microsoft.AspNetCore.Mvc;

namespace clothing_store.Controllers
{
    using BLL;
    using clothing_store.DAL.Models;
    using Common.Req;
    using Common.Rsp;

    [Route("api/[controller]")]
    [ApiController]
    public class CartsController : ControllerBase
    {
        public CartsController()
        {
            _svc = new CartsSvc();
        }

        [HttpPost("get-by-id")]
        public IActionResult getCartId([FromBody] SimpleReq rep)
        {
            var res = new SingleRsp();
            res = _svc.Read(rep.Id);
            return Ok(res);
        }

        [HttpPost("get-by-all")]
        public IActionResult getAllCarts([FromBody] SimpleReq rep)
        {
            var res = new SingleRsp();
            res.Data = _svc.All;
            return Ok(res);
        }

        // Create new
        [HttpPost("create-cart")]
        public IActionResult CreateCart([FromBody] CartsReq req)
        {
            var res = _svc.CreateCart(req);

            return Ok(res);
        }

        // Edit
        [HttpPost("update-cart")]
        public IActionResult UpdateCart([FromBody] CartsReq req)
        {
            var res = _svc.UpdateCart(req.UserId, req.ProductId, req.Size, req.Quantity);

            return Ok(res);
        }

        // Delete
        [HttpPost("delete-cart")]
        public IActionResult DeleteCart([FromBody] CartsReq req)
        {
            var res = _svc.DeleteCart(req.UserId);

            return Ok(res);

        }
            // Delete
        [HttpPost("delete-product-cart")]
        public IActionResult DeleteProductCart(Carts c)
        {
            var res = _svc.DeleteProductCart(c);
            
            return Ok(res);
        }

        //sửa
        [HttpPost("find-cart")]
        public IActionResult FindCart([FromBody] CartsReq req)
        {
            var res = _svc.FindCart(req.UserId);

            return Ok(res);
        }

            //get cart
        [HttpGet("get-cart/{id}")]
        public IActionResult GetCart_Linq(int id)
        {
            var res = new SingleRsp();
            var pro = _svc.GetCart_Linq(id);
            res.Data = pro;
            return Ok(res);
        }

        private readonly CartsSvc _svc;
    }
}