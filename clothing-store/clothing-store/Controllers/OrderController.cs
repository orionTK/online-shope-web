using Microsoft.AspNetCore.Mvc;

namespace clothing_store.Controllers
{
    using BLL;
    using Common.Req;
    using Common.Rsp;

    [Route("api/[controller]")]
    [ApiController]
    public class OrderController : ControllerBase
    {
        public OrderController()
        {
            _svc = new OrderSvc();
        }

        [HttpPost("get-by-id")]
        public IActionResult getOrderById([FromBody]SimpleReq req)
        {
            var res = new SingleRsp();
            res = _svc.Read(req.Id);
            return Ok(res); // 200: OK
        }

        [HttpPost("get-all")]
        public IActionResult getAllOrder()
        {
            var res = new SingleRsp();
            res.Data = _svc.All;
            return Ok(res);
        }

        [HttpPost("create-order")]
        public IActionResult CreateOrder([FromBody] OrderReq req)
        {
            var res = _svc.CreateOrder(req);

            return Ok(res);
        }


        [HttpPost("create-order-detail")]
        public IActionResult CreateOrderDetail([FromBody] OrderDetailsReq req)
        {
            var res = _svc.CreateOrderDetail(req);

            return Ok(res);
        }

        private readonly OrderSvc _svc;
    }
}