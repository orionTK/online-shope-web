using Microsoft.AspNetCore.Mvc;

namespace clothing_store.Controllers
{
    using BLL;
    using clothing_store.DAL.Models;
    using Common.Req;
    using Common.Rsp;

    [Route("api/[controller]")]
    [ApiController]
    public class OrderDetailsController : ControllerBase
    {
        public OrderDetailsController()
        {
            _svc = new OrderDetailsSvc();
        }

        // Create new
        [HttpPost("create-order-datails")]
        public IActionResult CreateOrderDetails([FromBody] OrderDetailsReq req)
        {
            var res = _svc.CreateOrderDetails(req);

            return Ok(res);
        }

        private readonly OrderDetailsSvc _svc;
    }
}