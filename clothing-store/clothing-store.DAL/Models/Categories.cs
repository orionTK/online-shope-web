using System;
using System.Collections.Generic;

namespace clothing_store.DAL.Models
{
    public partial class Categories
    {
        public Categories()
        {
            Products = new HashSet<Products>();
        }

        public int CategoryId { get; set; }
        public string CategoryName { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public bool Gender { get; set; }

        public virtual ICollection<Products> Products { get; set; }
    }
}
