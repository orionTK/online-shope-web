using System;
using System.Collections.Generic;
using System.Text;

namespace clothing_store.Common.Req
{
    public class OrderReq
    {
        public int OrderId { get; set; }
        public int UserId { get; set; }
        public DateTime OrderDate { get; set; }
        public string ShipName { get; set; }
        public string ShipAddress { get; set; }
        public string ShipPhoneNumber { get; set; }
        public bool? Status { get; set; }
    }
}
