﻿using System;
using System.Collections.Generic;
using System.Text;

namespace clothing_store.Common.Req
{
    public class OrderDetailsReq
    {
        public int OrderId { get; set; }
        public int ProductId { get; set; }
        public string Size { get; set; }
        public decimal UnitPrice { get; set; }
        public short Quantity { get; set; }
        public float Discount { get; set; }
    }
}
