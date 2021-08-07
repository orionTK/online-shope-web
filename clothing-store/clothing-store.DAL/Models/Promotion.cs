using System;
using System.Collections.Generic;

namespace clothing_store.DAL.Models
{
    public partial class Promotion
    {
        public Promotion()
        {
            Products = new HashSet<Products>();
        }

        public int PromotionId { get; set; }
        public string PromotionName { get; set; }
        public float DiscountPercent { get; set; }

        public virtual ICollection<Products> Products { get; set; }
    }
}
