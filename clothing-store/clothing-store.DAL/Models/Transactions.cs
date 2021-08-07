using System;
using System.Collections.Generic;

namespace clothing_store.DAL.Models
{
    public partial class Transactions
    {
        public string TransactionId { get; set; }
        public DateTime TransactionDate { get; set; }
        public decimal Fee { get; set; }
        public string Result { get; set; }
        public int UserId { get; set; }
        public int OrderId { get; set; }

        public virtual Orders Order { get; set; }
        public virtual Users User { get; set; }
    }
}
