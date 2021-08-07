using System;
using System.Collections.Generic;
using System.Text;

namespace clothing_store.Common.Req
{
    public class SearchPromotionReq
    {
        public int Page { get; set; }

        public int Size { get; set; }

        public int PromotionId { get; set; }

        public string Keyword { get; set; }
    }
}
