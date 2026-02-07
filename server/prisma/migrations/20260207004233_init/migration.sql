-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "tokens" INTEGER NOT NULL DEFAULT 0,
    "craftPoints" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Card" (
    "id" SERIAL NOT NULL,
    "gameId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "set" TEXT NOT NULL,
    "rarity" TEXT NOT NULL,
    "cardType" TEXT NOT NULL,
    "element" TEXT,
    "imageUrl" TEXT NOT NULL,

    CONSTRAINT "Card_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "NinjaStats" (
    "id" SERIAL NOT NULL,
    "cardId" INTEGER NOT NULL,
    "traits" TEXT[],
    "turnCost" INTEGER NOT NULL,
    "handCost" INTEGER NOT NULL DEFAULT 0,
    "healthyHead" INTEGER NOT NULL,
    "healthySupport" INTEGER NOT NULL,
    "injuredHead" INTEGER NOT NULL,
    "injuredSupport" INTEGER NOT NULL,
    "effectText" TEXT,

    CONSTRAINT "NinjaStats_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "JutsuStats" (
    "id" SERIAL NOT NULL,
    "cardId" INTEGER NOT NULL,
    "cost" TEXT NOT NULL,
    "effectText" TEXT NOT NULL,

    CONSTRAINT "JutsuStats_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MissionStats" (
    "id" SERIAL NOT NULL,
    "cardId" INTEGER NOT NULL,
    "turnCost" INTEGER NOT NULL,
    "handCost" INTEGER NOT NULL DEFAULT 0,
    "effectText" TEXT NOT NULL,

    CONSTRAINT "MissionStats_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Collection" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "cardId" INTEGER NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 1,
    "pulledAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Collection_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Card_gameId_key" ON "Card"("gameId");

-- CreateIndex
CREATE UNIQUE INDEX "NinjaStats_cardId_key" ON "NinjaStats"("cardId");

-- CreateIndex
CREATE UNIQUE INDEX "JutsuStats_cardId_key" ON "JutsuStats"("cardId");

-- CreateIndex
CREATE UNIQUE INDEX "MissionStats_cardId_key" ON "MissionStats"("cardId");

-- CreateIndex
CREATE UNIQUE INDEX "Collection_userId_cardId_key" ON "Collection"("userId", "cardId");

-- AddForeignKey
ALTER TABLE "NinjaStats" ADD CONSTRAINT "NinjaStats_cardId_fkey" FOREIGN KEY ("cardId") REFERENCES "Card"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JutsuStats" ADD CONSTRAINT "JutsuStats_cardId_fkey" FOREIGN KEY ("cardId") REFERENCES "Card"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MissionStats" ADD CONSTRAINT "MissionStats_cardId_fkey" FOREIGN KEY ("cardId") REFERENCES "Card"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Collection" ADD CONSTRAINT "Collection_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Collection" ADD CONSTRAINT "Collection_cardId_fkey" FOREIGN KEY ("cardId") REFERENCES "Card"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
